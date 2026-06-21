def greet(name)        # name 是局部变量，只在这个方法里有效
  message = "你好，#{name}"
  puts message
end

greet("小明")
puts message  # 这里会报错：undefined local variable