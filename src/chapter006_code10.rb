# 基础解构：数组解构
first, second, third = [1, 2, 3]
puts first   # => 1

# 哈希的键值解构
config = { host: 'localhost', port: 3000, debug: true }

# 方法一：分别提取
host = config[:host]
port = config[:port]
debug = config[:debug]

# 方法二：并行赋值（一次性提取）
host, port, debug = config.values_at(:host, :port, :debug)
puts "连接 #{host}:#{port}，调试模式: #{debug}"

# 方法三：slice提取子哈希（Ruby 3.0+）
ui_settings = config.slice(:host, :port)
puts ui_settings  # => {:host=>'localhost', :port=>3000}

# 方法四：解构在方法参数中的应用
def connect(host:, port:, debug:)
  puts "连接 #{host}:#{port}"
end
connect(host: 'localhost', port: 3000, debug: true)