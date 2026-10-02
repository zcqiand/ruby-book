# Ruby 方法以 def 关键字开头，后面跟方法名，以 end 结束
# 方法名推荐使用蛇底式命名（snake_case），这是 Ruby 社区惯例
# 方法定义后不会立即执行，只有被调用时才会运行
def greet
  # 字符串插值使用 #{}，比字符串拼接更清晰高效
  "Hello, Ruby!"
end

# 调用方法只需使用 方法名 + 括号（括号可省略，但不推荐）
message = greet()
puts message

# 无参数方法调用时括号可省略，但显式写括号是更好的风格
# 这样与其他带参数的方法调用风格一致，也更容易识别方法调用
result = greet
puts result