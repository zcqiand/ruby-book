numbers = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]

# sort 方法（默认升序，数字直接比大小）
# sort 默认使用 <=> 运算符，数字/字符串有内置比较逻辑
puts numbers.sort
# => [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

# sort 降序（传块或使用 reverse）
puts numbers.sort { |a, b| b <=> a }
# => [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]

# sort_by 方法（按指定表达式排序，更易读）
# 当需要按对象的某个属性排序时，sort_by 比 sort 块更简洁
users = [
  { name: "张三", age: 28, score: 85 },
  { name: "李四", age: 22, score: 92 },
  { name: "王五", age: 35, score: 78 },
  { name: "赵六", age: 28, score: 88 }
]
puts users.sort_by { |u| u[:age] }.map { |u| "#{u[:name]}(#{u[:age]})" }
# => [李四(22), 张三(28), 赵六(28), 王五(35)]

# 多字段排序（先按年龄，再按分数）
# Ruby 支持块内返回数组实现多级排序，数组从头比较到尾
puts users.sort_by { |u| [u[:age], -u[:score]] }.map { |u| "#{u[:name]}(#{u[:age]}, #{u[:score]})" }
# => [李四(22, 92), 赵六(28, 88), 张三(28, 85), 王五(35, 78)]

# 忽略大小写排序
words = ["banana", "apple", "cherry", "Date", "date"]
puts words.sort_by(&:downcase)
# => [apple, banana, cherry, date, Date]

# sort! 就地排序（修改原数组）
# sort! 直接修改原数组，sort 返回新数组，节省内存时用 sort!
arr = [5, 3, 1, 2, 4]
arr.sort!
puts "原数组被修改: #{arr}"
# => [1, 2, 3, 4, 5]

# 复杂排序示例：按数组长度，再按字母顺序
data = ["cat", "dog", "elephant", "bee", "ant", "lion"]
puts data.sort_by { |w| [w.length, w] }
# => [ant, bee, cat, dog, lion, elephant]