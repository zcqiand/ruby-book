numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 2.1 变换类方法

# map：对每个元素进行变换，返回新数组
# 用途：数据转换、提取字段、格式整理
squares = numbers.map { |n| n ** 2 }
puts "numbers.map { |n| n ** 2 }  =>  #{squares}"

# 提取对象属性时常用
users = [
  { name: "Alice", age: 25 },
  { name: "Bob", age: 30 },
  { name: "Charlie", age: 35 }
]
names = users.map { |u| u[:name] }
puts "提取用户名: #{names}"