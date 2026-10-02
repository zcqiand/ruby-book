# 两种写法等价
add = lambda { |a, b| a + b }
multiply = ->(a, b) { a * b }   # 箭头语法，更现代

puts add.call(3, 4)       # => 7
puts multiply.call(3, 4)  # => 12