puts "2 + 3 * 4 = #{2 + 3 * 4}"           # => 14（乘法优先）
puts "(2 + 3) * 4 = #{(2 + 3) * 4}"       # => 20（括号最高）
puts "1 + 2 == 3 = #{1 + 2 == 3}"         # => true（先加后比较）
puts "true && false || true = #{true && false || true}"  # => true（先&&后||）