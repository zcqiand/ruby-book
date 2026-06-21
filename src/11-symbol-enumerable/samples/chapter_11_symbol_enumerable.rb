#!/usr/bin/env ruby
# frozen_string_literal: true

# 第 11 章：符号(Symbol)与枚举
# 代码示例 - 展示 Symbol 和 Enumerable 的核心用法

puts "=" * 60
puts "第 11 章：符号(Symbol)与枚举"
puts "=" * 60

# ============================================================
# 1. Symbol 与 String 对比
# ============================================================

puts "\n【1. Symbol 与 String 对比】\n\n"

# 1.1 Symbol 的创建和基本用法
# Symbol 以冒号开头，创建后不可变，适合作为标识符使用
# 与字符串不同，相同内容的 Symbol 只有一份内存实例

# 创建 Symbol 的三种方式
sym1 = :hello
sym2 = :"world"
sym3 = %i[foo bar]  # 用 %i 创建符号数组，字面量语法更简洁

puts "Symbol 创建示例:"
puts "sym1 = :hello  =>  #{sym1.inspect}"
puts "sym2 = :\"world\"  =>  #{sym2.inspect}"
puts "%i[foo bar]  =>  #{sym3.inspect}"

# 1.2 Symbol vs String 内存对比
# 关键区别：Symbol 是唯一的，String 会重复创建
# 用 object_id 验证：相同内容的 Symbol 共享同一对象

puts "\n1.2 Symbol vs String 内存对比（object_id）:"
puts "-" * 40

# Symbol：相同内容共享同一个 object_id
sym_a1 = :ruby
sym_a2 = :ruby
puts "Symbol :ruby 两个变量 object_id 相同: #{sym_a1.object_id == sym_a2.object_id} (#{sym_a1.object_id} == #{sym_a2.object_id})"

# String：每次创建都是新对象
str_b1 = "ruby"
str_b2 = "ruby"
puts "String \"ruby\" 两个变量 object_id 相同: #{str_b1.object_id == str_b2.object_id} (#{str_b1.object_id} != #{str_b2.object_id})"

puts "\n结论：Symbol 节省内存，适合作为哈希键和枚举值"

# 1.3 Symbol 作为哈希键的优势
# 哈希查找时 Symbol 比 String 更快（无需比较字符内容）

puts "\n1.3 Symbol 作为哈希键的优势:"
puts "-" * 40

# 使用 Symbol 作为键
config = {
  name: "XR-Knowledge",
  version: "1.0",
  author: "Ruby Learner"
}

# 访问方式：支持点号语法（实际上也是 Symbol 键的语法糖）
puts "config[:name]  =>  #{config[:name]}"
puts "config.name    =>  #{config.name}" if config.respond_to?(:name)

# 对比：String 键需要引号
string_key_config = {
  "name" => "XR-Knowledge",
  "version" => "1.0"
}
puts "\nString 键配置:"
puts "string_key_config[\"name\"]  =>  #{string_key_config["name"]}"

# Symbol 与 String 互转
puts "\n1.4 Symbol 与 String 互转:"
puts "-" * 40
sym_to_str = :hello.to_s
str_to_sym = "world".to_sym
puts ":hello.to_s  =>  #{sym_to_str.inspect} (#{sym_to_str.class})"
puts "\"world\".to_sym  =>  #{str_to_sym.inspect} (#{str_to_sym.class})"

# ============================================================
# 2. Enumerable 枚举方法
# ============================================================

puts "\n\n【2. Enumerable 枚举方法】\n\n"

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 2.1 变换类方法

puts "2.1 变换类方法:"
puts "-" * 40

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

# 2.2 筛选类方法

puts "\n2.2 筛选类方法:"
puts "-" * 40

# select：保留满足条件的元素
evens = numbers.select { |n| n.even? }
puts "numbers.select { |n| n.even? }  =>  #{evens}"

# reject：排除满足条件的元素（select 的相反操作）
odd_greater_than_5 = numbers.reject { |n| n <= 5 || n.even? }
puts "numbers.reject { |n| n <= 5 || n.even? }  =>  #{odd_greater_than_5}"

# 2.3 聚合类方法

puts "\n2.3 聚合类方法:"
puts "-" * 40

# reduce：将元素聚合成单个值
# 初始值为 0，从左到右累加
sum = numbers.reduce(0) { |acc, n| acc + n }
puts "numbers.reduce(0) { |acc, n| acc + n }  =>  #{sum}"

# 无初始值时，使用第一个元素作为初始值
product = numbers.reduce { |acc, n| acc * n }
puts "numbers.reduce { |acc, n| acc * n }  =>  #{product}"

# 常用简写形式
puts "numbers.sum  =>  #{numbers.sum}"
puts "numbers.max  =>  #{numbers.max}"
puts "numbers.min  =>  #{numbers.min}"

# 2.4 查找类方法

puts "\n2.4 查找类方法:"
puts "-" * 40

# find：查找第一个满足条件的元素，找到返回元素，否则返回 nil
first_divisible_by_3 = numbers.find { |n| n % 3 == 0 }
puts "numbers.find { |n| n % 3 == 0 }  =>  #{first_divisible_by_3}"

# first：获取前 N 个元素
first_3 = numbers.first(3)
puts "numbers.first(3)  =>  #{first_3}"

# take：提取前 N 个元素（与 first 功能相同）
taken = numbers.take(4)
puts "numbers.take(4)  =>  #{taken}"

# sample：随机选取元素（不重复）
random_sample = numbers.sample(3)
puts "numbers.sample(3)  =>  #{random_sample}"

# 随机选取单个元素
single_random = numbers.sample
puts "numbers.sample  =>  #{single_random}"

# find_all 是 select 的别名
multiples_of_2 = numbers.find_all { |n| n % 2 == 0 }
puts "numbers.find_all { |n| n % 2 == 0 }  =>  #{multiples_of_2}"

# ============================================================
# 3. 方法链
# ============================================================

puts "\n\n【3. 方法链】\n\n"

# 方法链：多个 Enumerable 方法组合使用
# 典型模式：先筛选、再变换、最后聚合

scores = [45, 72, 88, 91, 65, 78, 94, 50, 83, 67]

puts "原始成绩: #{scores}"
puts "-" * 40

# 场景：计算及格学生（>=60）的平均分
# 步骤：1) 筛选及格  2) 计算平均
passing_avg = scores.select { |s| s >= 60 }.reduce(:+) / scores.count { |s| s >= 60 }
puts "及格学生平均分: #{passing_avg}"

# 链式写法：过滤出优秀成绩（>=90），提取前2个，平方后求和
top_2_squared_sum = scores.select { |s| s >= 90 }.first(2).map { |s| s ** 2 }.sum
puts "优秀成绩前2名平方和: #{top_2_squared_sum}"

# 演示方法链的执行过程
puts "\n方法链分解演示:"
intermediate_1 = scores.select { |s| s >= 80 }  # 第一步：筛选 >=80
puts "1. 筛选 >=80: #{intermediate_1}"
intermediate_2 = intermediate_1.sort.reverse.first(3)  # 第二步：排序取前3
puts "2. 排序取前3: #{intermediate_2}"
result = intermediate_2.map { |s| "第#{intermediate_2.index(s) + 1}名: #{s}" }  # 第三步：格式化
puts "3. 格式化: #{result}"

# 组合比较：查找最高分的奇数成绩
highest_odd = scores.select(&:odd?).max
puts "\n最高奇数分: #{highest_odd}"

# 使用 enum_for 创建懒枚举（Ruby 2.x+）
# lazy 可以避免中间数组创建，优化大数据处理
puts "\n使用 lazy 优化（不创建中间数组）:"
result_lazy = numbers.lazy.map { |n| n ** 2 }.select { |n| n > 25 }.first(3).to_a
puts "numbers.lazy.map { |n| n ** 2 }.select { |n| n > 25 }.first(3)  =>  #{result_lazy}"

puts "\n" + "=" * 60
puts "代码示例结束"
puts "=" * 60
