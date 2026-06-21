module Helper
  def greet
    "Hello from #{self.class}"
  end

  def self.module_method
    "这是模块自己的方法"
  end
end

class A
  include Helper  # 实例方法版本：所有 A 的实例都能调用 greet
end

class B
  extend Helper  # 类方法版本：B 类本身能调用 greet，B 的实例反而不能
end

puts "=== include vs extend 对比 ==="
a = A.new
puts "A.new.greet: #{a.greet}"           # => "Hello from A"

b = B.new
puts "B.greet (类方法): #{B.greet}"       # => "Hello from B"
puts "B.new.greet 尝试: #{b.greet rescue "NoMethodError"}"

# 方法查找链揭示真相
puts "\nA 的祖先链: #{A.ancestors.take(4).inspect}"
puts "B 的祖先链: #{B.ancestors.take(4).inspect}"