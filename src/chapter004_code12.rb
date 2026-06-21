# 1. Range === 用于判断值是否在范围内（最常见的用途）
puts "(1..10) === 5 = #{(1..10) === 5}"   # => true
puts "(1..10) === 15 = #{(1..10) === 15}" # => false

# 2. Regexp === 用于正则匹配
puts "/ruby/ === 'hello ruby' = #{/ruby/ === 'hello ruby'}"  # => true

# 3. Class === 用于判断是否是类的实例
puts "String === 'hello' = #{String === 'hello'}"    # => true
puts "Integer === 42 = #{Integer === 42}"              # => true

# 4. Integer === 等同于 ==
puts "5 === 5 = #{5 === 5}"               # => true（Integer 的 === 等同于 ==）