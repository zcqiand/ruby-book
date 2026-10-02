# **kwargs 将所有剩余关键字参数收集为一个 Hash
# 关键字参数优点：调用时可按名传参，顺序无关，无需记忆参数顺序
# Ruby 3.0 引入独立关键字参数语法，与 Hash 参数明确区分
def create_user(name:, email:, role: "member", active: true)
  # 返回 Hash 比返回多个值更灵活，调用方可以按需提取
  # 符号作为 Hash 键比字符串键更符合 Ruby 惯例
  {
    name: name,
    email: email,
    role: role,
    active: active,
    created_at: Time.now
  }
end

# 调用时必须显式指定关键字参数名，TypeScript 风格的安全检查
# 缺少必需参数会立即报 ArgumentError，而非运行时才发现
user1 = create_user(name: "张三", email: "zhang@example.com")
puts "用户1（只用必需参数）: #{user1[:name]}, #{user1[:role]}"

# 覆盖默认值：传 role 参数
user2 = create_user(name: "李四", email: "li@example.com", role: "admin")
puts "用户2（管理员）: #{user2[:name]}, #{user2[:role]}"

# 关键字参数顺序无关
user3 = create_user(email: "wang@example.com", name: "王五", active: false)
puts "用户3（禁用状态）: #{user3[:name]}, #{user3[:active]}"

# 必需参数不能省略，否则报错（这是关键字参数的安全设计）
# create_user(name: "测试") # => 会报 email 缺失错误