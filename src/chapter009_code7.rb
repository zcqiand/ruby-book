def greet(name = "朋友")
  puts "你好，#{name}！"
end

greet("小明")   # 输出: 你好，小明！
greet           # 输出: 你好，朋友！