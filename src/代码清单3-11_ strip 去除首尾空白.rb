text = "  hello  "

puts text.strip      # 输出：hello（去除首尾空格）
puts text.lstrip     # 输出：hello   （去除左侧空格）
puts text.rstrip     # 输出：  hello（去除右侧空格）
puts text.strip.length  # 输出：5（去空格后长度为 5）