# 闭区间: .. 包含结束点
(1..5).each { |n| print "#{n} " }
puts

# 半开区间: ... 不包含结束点
(1...5).each { |n| print "#{n} " }
puts

# 字符范围也可以
('a'..'e').each { |c| print "#{c} " }
puts