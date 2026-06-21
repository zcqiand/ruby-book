age = 25
income = 50000

# &&：两个条件都必须为 true
puts "age > 18 && income > 30000 = #{age > 18 && income > 30000}"  # => true

# ||：至少一个条件为 true
puts "age > 30 || income > 100000 = #{age > 30 || income > 100000}" # => false

# !：取反
puts "!(age > 30) = #{!(age > 30)}"      # => true