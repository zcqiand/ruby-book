input = "   RUbY   "
result = input.strip.downcase.capitalize.gsub("ruby", "Ruby").prepend("编程语言：")
puts result
dirty = "  电话: 138-1234-5678  \n"
clean = dirty.strip.gsub(/\D/, "").gsub(/(\d{3})(\d{4})(\d{4})/, '\1-\2-\3')
puts clean
# 预期输出：
# 编程语言：Ruby
# 138-1234-5678