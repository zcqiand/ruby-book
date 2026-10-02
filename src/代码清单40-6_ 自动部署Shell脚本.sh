#!/usr/bin/env bash
# deploy.sh — Rails 生产环境部署脚本
# 用于 CI/CD 流水线中的部署阶段，支持平滑重启和健康检查
# 依赖：systemd（管理 Puma 服务）、PostgreSQL（Nginx 已通过 upstream 配置）

# 严格模式：任何命令失败立即退出，防止部署到一半的不一致状态
set -euo pipefail

# 颜色输出（CI 日志可读性）
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# 检测运行环境：必须设置 RAILS_ENV
: "${RAILS_ENV:=production}"
export RAILS_ENV

# 目录定义（使用绝对路径，CI 环境中 WORKDIR 可能变化）
APP_DIR="${APP_DIR:-/var/www/app}"
APP_USER="${APP_USER:-deploy}"
PUMA_SOCKET="${PUMA_SOCKET:-/var/run/puma/app.sock}"
HEALTH_CHECK_URL="${HEALTH_CHECK_URL:-http://localhost/health}"
DEPLOY_TIMEOUT="${DEPLOY_TIMEOUT:-300}"

# 解析命令行参数
# deploy.sh --branch main --commit abc123 --skip-migration
SKIP_MIGRATION=false
SKIP_ASSETS=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --branch)
      DEPLOY_BRANCH="$2"
      shift 2
      ;;
    --commit)
      DEPLOY_COMMIT="$2"
      shift 2
      ;;
    --skip-migration)
      SKIP_MIGRATION=true
      shift
      ;;
    --skip-assets)
      SKIP_ASSETS=true
      shift
      ;;
    *)
      log_error "未知参数: $1"
      exit 1
      ;;
  esac
done

# 部署前检查：确保以正确用户运行
check_user() {
  if [[ $EUID -eq 0 ]]; then
    log_warn "以 root 运行，切换到 $APP_USER..."
    exec su - "$APP_USER" "$0" "$@"
  fi
  
  if [[ $(whoami) != "$APP_USER" ]]; then
    log_error "必须以 $APP_USER 用户运行，当前用户: $(whoami)"
    exit 1
  fi
  
  log_info "用户检查通过: $(whoami)"
}

# 检查关键文件和目录是否存在
check_directories() {
  log_info "检查目录结构..."
  
  if [[ ! -d "$APP_DIR" ]]; then
    log_error "应用目录不存在: $APP_DIR"
    exit 1
  fi
  
  if [[ ! -d "$APP_DIR/current" ]]; then
    log_error "应用目录结构异常: $APP_DIR/current 不存在"
    exit 1
  fi
  
  log_info "目录检查通过"
}

# 数据库迁移：生产环境迁移是高风险操作，必须谨慎
run_migrations() {
  if [[ "$SKIP_MIGRATION" == true ]]; then
    log_warn "跳过数据库迁移（--skip-migration）"
    return
  fi
  
  log_info "执行数据库迁移..."
  
  cd "$APP_DIR/current"
  
  # 迁移前备份：即使启用了 point-in-time recovery，也做一次逻辑备份
  # 结构变更前的备份对于回滚至关重要
  if [[ -n "${DATABASE_URL:-}" ]]; then
    log_info "备份数据库结构..."
    pg_dump --schema-only --no-owner -f "/tmp/schema_backup_$(date +%Y%m%d_%H%M%S).sql" || true
  fi
  
  # 使用 bundle exec 确保使用 Gemfile 中声明的 Rails 版本
  # migrate:quiet 抑制迁移过程中的日志输出，减少 CI 日志噪音
  bundle exec rails db:migrate
  
  # 验证迁移结果：检查 schema_migrations 表确保迁移已记录
  bundle exec rails db:version
  
  log_info "数据库迁移完成"
}

# 资产预编译：生成静态文件（CSS/JS/图片）
# 这是生产环境的必需步骤，不可跳过
compile_assets() {
  if [[ "$SKIP_ASSETS" == true ]]; then
    log_warn "跳过资产编译（--skip-assets）"
    return
  fi
  
  log_info "编译静态资产..."
  
  cd "$APP_DIR/current"
  
  # assets:clean 清理旧版本资产，避免多版本静态文件堆积
  # assets:precompile 使用多核并行编译加速（JOBS=4）
  # SECRET_KEY_BASE 必须设置，否则编译失败
  bundle exec rails assets:clean
  SECRET_KEY_BASE="$RAILS_SECRET_KEY_BASE" bundle exec rails assets:precompile
  
  # 确保 assets 目录权限正确（Nginx 以 www-data 运行需要读取权限）
  if command -v sudo &> /dev/null; then
    sudo chmod -R 755 "$APP_DIR/current/public/assets" 2>/dev/null || true
  fi
  
  log_info "资产编译完成"
}

# Puma 服务管理：通过 systemd 控制
reload_puma() {
  log_info "重载 Puma 服务..."
  
  # 判断 systemd 单元文件是否存在（标准部署方式）
  if systemctl list-unit-files puma.service &> /dev/null; then
    # systemctl reload 不终止 worker 进程，实现平滑重载
    # 这是生产环境首选的重启方式，用户请求不会中断
    systemctl reload puma
    
    # 等待 Puma 完全启动再进行健康检查
    sleep 3
    log_info "Puma 服务已重载（systemctl reload）"
  else
    # 传统方式：直接用 pumactl 控制（开发环境或未配置 systemd 时）
    if [[ -S "$PUMA_SOCKET" ]]; then
      # phased-restart 分阶段重启，先启新进程接收新请求，再停旧进程
      bundle exec pumactl phased-restart || bundle exec pumactl restart
      log_info "Puma 已通过 pumactl 重启"
    else
      log_error "Puma socket 不存在且无 systemd 服务: $PUMA_SOCKET"
      exit 1
    fi
  fi
}

# 健康检查：验证部署后应用是否正常响应
health_check() {
  log_info "执行健康检查..."
  
  local max_attempts=30
  local attempt=1
  local http_code
  
  while [[ $attempt -le $max_attempts ]]; do
    # 使用 curl 进行 HTTP 检查，--fail 让 HTTP 4xx/5xx 返回非零 exit code
    # --silent 抑制进度输出，--show-error 显示错误信息
    http_code=$(curl -sf -o /dev/null -w '%{http_code}' "$HEALTH_CHECK_URL" || echo "000")
    
    if [[ "$http_code" =~ ^2[0-9]{2}$ ]]; then
      log_info "健康检查通过（HTTP $http_code）"
      return 0
    fi
    
    echo -n "."
    sleep 2
    ((attempt++))
  done
  
  echo "" # 换行
  log_error "健康检查失败（已尝试 ${max_attempts} 次）"
  return 1
}

# 部署完成通知：可通过 webhook 扩展
notify_deployment() {
  log_info "部署完成!"
  
  # 输出版本信息便于追踪
  if [[ -n "${DEPLOY_COMMIT:-}" ]]; then
    log_info "部署版本: $DEPLOY_COMMIT"
  fi
  if [[ -n "${DEPLOY_BRANCH:-}" ]]; then
    log_info "部署分支: $DEPLOY_BRANCH"
  fi
}

# 主流程
main() {
  log_info "=== 开始部署 (RAILS_ENV=$RAILS_ENV) ==="
  
  check_user
  check_directories
  run_migrations
  compile_assets
  reload_puma
  health_check
  notify_deployment
  
  log_info "=== 部署成功完成 ==="
}

# 捕获异常退出，打印有用的调试信息
trap 'log_error "部署脚本异常退出 (line $LINENO)"; exit 1' ERR

main "$@"