str = "Hello 世界"
puts str.length
puts str.bytesize
puts str[0]
puts str[-1]
puts str[6..10]
puts str.each_char { |ch| print "#{ch} " }
# 预期输出：
# 10
# 14
# H
# 界
# 世界
# H e l l o   世 界