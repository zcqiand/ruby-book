text = "  Hello Ruby World  "
puts text.upcase
puts text.downcase
puts text.capitalize
puts text.strip
puts "原始值：'#{text}'"
# 预期输出：
#   HELLO RUBY WORLD
#   hello ruby world
#   hello ruby world  （capitalize 不去除空格，首字符大写其余小写）
# Hello Ruby World
# 原始值：'  Hello Ruby World  '