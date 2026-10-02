result1 = true && false
result2 = true and false  # 实际执行顺序：(result2 = true) and false
puts "true && false = #{result1}"            # => false
puts "true and false = #{result2}"            # => true（先赋值后比较）