username = "  Alice123  "
email = "alice@example.com"

# 清洗用户名
clean_username = username.strip

# 检查有效性
is_valid = clean_username.length >= 3 && 
           clean_username.downcase.include?("alice")

puts "用户名：#{clean_username}"
puts "有效？#{is_valid}"
# 输出：
# 用户名：Alice123
# 有效？true