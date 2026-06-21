# ||= 的含义：如果变量为 nil 或 false，则赋值
config = nil
config ||= "default_value"
puts config  # => default_value

# 已有值时不会覆盖
config = "user_value"
config ||= "default_value"
puts config  # => user_value