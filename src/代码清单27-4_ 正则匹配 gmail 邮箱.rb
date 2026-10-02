# 匹配gmail邮箱的模式
pattern = /@gmail\.com$/i

# $ 表示结尾，i 表示不区分大小写
puts 'zhangsan@gmail.com' =~ pattern  # 匹配成功，返回索引
puts 'zhangsan@google.com' =~ pattern # 不匹配，返回nil