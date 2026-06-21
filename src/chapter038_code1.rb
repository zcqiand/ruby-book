# Puma生产环境配置
# 为什么：开发环境单线程无法应对生产环境并发，多进程+多线程是Rails推荐的生产方案

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# 为什么：development 环境不预启动，staging 和 production 预启动保证响应速度
preload_app!

# 为什么：指定 PID 文件位置，方便 systemd 管理
pid ENV.fetch("PIDFILE") { "tmp/pids/puma.pid" }

# 为什么：生产环境需要工作目录隔离，防止路径问题
working_directory ENV.fetch("APP_HOME") { Rails.root }

# 为什么：production 环境开启日志重定向，让 systemd journalctl 收集日志
stdout_redirect ENV.fetch("STDOUT_LOG") { "log/puma.stdout.log" },
              ENV.fetch("STDERR_LOG") { "log/puma.stderr.log" },
              true  # append 模式

# 为什么：多进程模式下每个进程监听不同端口，通过 socket 共享
bind "unix://#{ENV.fetch("PUMA_SOCKET") { "tmp/sockets/puma.sock" }}"

# 为什么：workers 数量建议 CPU 核数，这里用环境变量灵活配置
workers ENV.fetch("PUMA_WORKERS") { 2 }

# 为什么：restart_timeout 控制优雅重启间隔，太短可能导致频繁重启
restart_timeout 20