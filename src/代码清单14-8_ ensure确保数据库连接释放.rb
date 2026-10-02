# frozen_string_literal: true

# 场景：数据库连接管理
# 为什么要用 ensure：无论连接成功、抛出异常还是提前 return，资源必须释放

class DatabaseConnection
  attr_reader :connected

  def initialize(name)
    @name = name
    @connected = false
  end

  def connect
    @connected = true
    puts "[#{@name}] 连接已建立"
    self
  end

  def query(sql)
    raise "未建立连接" unless @connected
    puts "[#{@name}] 执行: #{sql}"
    { rows: 10, status: :ok }
  end

  def disconnect
    if @connected
      @connected = false
      puts "[#{@name}] 连接已关闭"
    end
  end
end

def with_database(name)
  db = DatabaseConnection.new(name)
  db.connect
  yield db
ensure
  db&.disconnect
end

puts "=== 场景1：正常流程 ==="
with_database('primary') do |db|
  db.query('SELECT * FROM users')
end

puts "\n=== 场景2：中间抛出异常 ==="
begin
  with_database('replica') do |db|
    db.query('SELECT * FROM orders')
    raise '网络中断！'
    db.query('SELECT * FROM products')
  end
rescue => e
  puts "捕获异常: #{e.message}"
end

puts "\n=== 场景3：提前 return ==="
def fetch_and_disconnect
  db = DatabaseConnection.new('cache')
  db.connect
  return "数据" if true
ensure
  db&.disconnect
end
result = fetch_and_disconnect
puts "返回结果: #{result}"