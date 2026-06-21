# 用户原始输入
raw_input = "  alice  "

# 链式处理：去空格 → 首字母大写 → 获取长度
result = raw_input.strip.capitalize

puts "处理后：#{result}"
# 输出：处理后：Alice
puts "名字长度：#{result.length}"
# 输出：名字长度：5