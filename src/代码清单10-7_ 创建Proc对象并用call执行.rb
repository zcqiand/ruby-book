# 用 Proc.new 或 proc 关键字创建
double = Proc.new { |x| x * 2 }
square = proc { |x| x ** 2 }

# 用 call 方法执行
puts double.call(5)   # => 10
puts square.call(5)   # => 25