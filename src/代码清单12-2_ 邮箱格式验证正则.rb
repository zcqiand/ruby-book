def valid_email?(email)
  # 简化的邮箱验证正则：名字部分 + @ + 域名部分
  /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/ =~ email
end

valid_email?("user@example.com")     # 7 (匹配成功)
valid_email?("test@")                # nil (匹配失败)
valid_email?("@example.com")         # nil (匹配失败)
valid_email?("user@.com")            # nil (匹配失败)