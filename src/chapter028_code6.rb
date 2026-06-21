# app_with_middleware.rb
# 演示如何让 Sinatra 使用自定义中间件

require 'sinatra'
require 'rack'

# 加载中间件类（假设在同一目录）
require_relative 'middleware/timing_logger'

# 使用 use 语句将中间件插入到处理链
# 为什么用 use 而不是直接调用：Rack 的中间件栈是洋葱模型，
# use 语句声明的中间件会按声明顺序层层包裹应用
use TimingLogger

get '/' do
  '欢迎访问！每次请求都会记录处理时间。'
end

get '/slow' do
  # 模拟耗时操作（实际项目中可能是数据库查询）
  sleep 2
  '这是一个慢页面，耗时 2 秒。'
end

get '/fast' do
  '这个页面很快！'
end

if __FILE__ == $0
  puts "带中间件的应用已启动，访问 http://localhost:4567/"
  run!
end