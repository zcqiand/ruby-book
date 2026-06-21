fruits = ['apple', 'banana', 'cherry', 'date']
fruits[0]      # => 'apple'
fruits[-1]     # => 'date'
fruits[1..2]   # => ['banana', 'cherry']
fruits[2..]    # => ['cherry', 'date'] (Ruby 3.0+)
fruits[..2]    # => ['apple', 'banana', 'cherry'] (Ruby 3.0+)

# at 方法（安全访问，越界返回 nil 而非报错）
# 比 [] 更安全，适合不确定索引是否有效的场景
puts "at(-10): #{fruits.at(-10)}"  # => nil（越界不报错）

# first / last 方法（语义更清晰，比 [0] 和 [-1] 更易读）
puts "first: #{fruits.first}"      # => 'apple'
puts "last: #{fruits.last}"        # => 'date'
puts "前2个: #{fruits.first(2)}"   # => ['apple', 'banana']
puts "后2个: #{fruits.last(2)}"    # => ['cherry', 'date']