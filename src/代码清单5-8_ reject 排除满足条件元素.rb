# 排除未成年
ages.reject { |age| age < 18 }  # => [23, 19, 45, 32]