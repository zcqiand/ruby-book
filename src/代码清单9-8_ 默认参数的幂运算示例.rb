# 默认参数在参数名后加 = 值，调用时不传该参数则使用默认值
# Ruby 3.0+ 支持在位置参数中使用默认参数
# 默认参数使方法更灵活，无需重载即可提供默认行为
def power(base, exponent = 2)
  # ** 是 Ruby 的幂运算符，Ruby 1.8 引入，比乘法和 pow 函数更清晰
  base ** exponent
end

# 调用时只传必需参数，使用默认指数 2（即平方）
square = power(3)
puts "3 的平方: #{square}"

# 显式传 exponent 参数，覆盖默认值
cube = power(3, 3)
puts "3 的立方: #{cube}"

# 位置参数按顺序绑定，传参顺序不能颠倒
# 如果需要按非顺序传参，可使用关键字参数（见后例）
result = power(5, 4)
puts "5 的 4 次方: #{result}"