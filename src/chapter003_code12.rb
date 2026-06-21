text = "Hello World"

# 查找：是否包含某个子串
puts text.include?("World")   # 输出：true
puts text.include?("Python")  # 输出：false

# 替换：gsub 是全局替换
puts text.gsub("World", "Ruby")  # 输出：Hello Ruby
puts text.gsub("o", "0")        # 输出：Hell0 W0rld

# 分割：按分隔符拆分为数组
puts "apple,banana,orange".split(",")  # 输出：["apple", "banana", "orange"]

# 重复
puts "Ha" * 3  # 输出：HaHaHa