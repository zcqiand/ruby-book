# middleware/timing_logger.rb
# 为什么用类封装：Rack 中间件必须遵循 call(env) 接口规范
# 这样可以被 config.ru 加载并插入到请求处理链中

class TimingLogger
  # env 是 Rack 环境变量字典，包含请求的所有信息
  # @app 保存下一个中间件或最终应用的引用，形成调用链
  def initialize(app)
    @app = app
  end

  # 每个中间件必须实现 call 方法，返回 [状态码, 响应头, 响应体] 数组
  def call(env)
    # 记录请求开始时间（高精度计时）
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    
    # 调用链中的下一个组件（可能是另一个中间件或 Sinatra 应用）
    status, headers, body = @app.call(env)
    
    # 计算处理耗时
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
    
    # 输出日志（实际项目中会写入日志文件）
    puts "[#{Time.now}] #{env['REQUEST_METHOD']} #{env['PATH_INFO']} - #{status} - #{'%.2f' % elapsed}s"
    
    # 必须返回 [status, headers, body]，否则请求链会中断
    [status, headers, body]
  end
end