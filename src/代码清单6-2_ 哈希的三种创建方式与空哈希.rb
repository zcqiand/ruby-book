# 方式一：符号键简写（Ruby 2.2+，推荐）
user = { name: 'Alice', age: 30, city: 'Beijing' }

# 方式二：传统火箭符号 =>
user = { :name => 'Alice', :age => 30, :city => 'Beijing' }

# 方式三：字符串键
config = { 'host' => 'localhost', 'port' => 3000 }

# 空哈希
empty = {}
also_empty = Hash.new

# Hash.new 带默认值（访问不存在的键返回默认值而非nil）
scores = Hash.new(0)
scores[:math]  # => 0（默认值为0）