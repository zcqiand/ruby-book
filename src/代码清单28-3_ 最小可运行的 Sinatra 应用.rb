# app.rb — 最小可运行的 Sinatra 应用
# 为什么不到 30 行：因为 Sinatra 的 DSL 已经封装了所有复杂度
# 读者只需关注路由定义，不需要了解底层 Rack 协议细节

require 'sinatra'

# 定义根路径路由，当用户访问 http://localhost:4567/ 时触发
get '/' do
  # Sinatra 会自动将字符串作为 HTML 响应返回
  'Hello, Ruby 新手！欢迎来到 Web 开发世界。'
end

# 启动服务器（仅在直接运行此文件时生效）
# 这样做的好处是：可以通过 `ruby app.rb` 直接启动，而不是用 rackup 命令
if __FILE__ == $0
  puts "Sinatra 服务器已启动，访问 http://localhost:4567/"
  run!
end