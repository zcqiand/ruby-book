#!/usr/bin/env bash
# deploy_check.sh - 部署前检查脚本
# 为什么：手动部署容易遗漏步骤，脚本化保证每一步都执行到位

set -e  # 遇到错误立即退出

echo "=== 部署前检查 ==="

# 检查 Puma 进程是否运行
if pgrep -f "puma" > /dev/null; then
  echo "[OK] Puma 进程运行中"
else
  echo "[WARN] Puma 未运行，请先启动服务"
fi

# 检查 Nginx 配置语法
if nginx -t; then
  echo "[OK] Nginx 配置语法正确"
else
  echo "[ERROR] Nginx 配置有误，请检查"
  exit 1
fi

# 检查 Unix socket 是否存在
SOCKET_PATH="PATH_TO_YOUR_APP/shared/sockets/puma.sock"
if [ -S "$SOCKET_PATH" ]; then
  echo "[OK] Puma socket 存在: $SOCKET_PATH"
else
  echo "[ERROR] Puma socket 不存在: $SOCKET_PATH"
  exit 1
fi

# 检查关键环境变量
REQUIRED_VARS=("RAILS_ENV" "DATABASE_URL" "SECRET_KEY_BASE")
for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "[ERROR] 环境变量 $var 未设置"
    exit 1
  else
    echo "[OK] $var 已设置"
  fi
done

echo "=== 检查完成 ==="