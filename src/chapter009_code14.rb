def safe_divide(dividend, divisor)
  if divisor == 0
    return "错误：除数不能为0"
  end
  dividend / divisor
end

puts safe_divide(10, 2)   # 输出: 5
puts safe_divide(10, 0)   # 输出: 错误：除数不能为0