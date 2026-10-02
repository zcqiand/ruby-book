# 找出所有成年(>=18)的人
ages = [23, 19, 45, 17, 32]
adults = ages.select { |age| age >= 18 }  # => [23, 19, 45, 32]