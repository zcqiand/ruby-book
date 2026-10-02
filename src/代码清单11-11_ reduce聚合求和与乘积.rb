
# reduce：将元素聚合成单个值
# 初始值为 0，从左到右累加
sum = numbers.reduce(0) { |acc, n| acc + n }
puts "numbers.reduce(0) { |acc, n| acc + n }  =>  #{sum}"

# 无初始值时，使用第一个元素作为初始值
product = numbers.reduce { |acc, n| acc * n }
puts "numbers.reduce { |acc, n| acc * n }  =>  #{product}"

# 常用简写形式
puts "numbers.sum  =>  #{numbers.sum}"
puts "numbers.max  =>  #{numbers.max}"
puts "numbers.min  =>  #{numbers.min}"