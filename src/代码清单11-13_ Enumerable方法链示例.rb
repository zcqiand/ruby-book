# 方法链：多个 Enumerable 方法组合使用
# 典型模式：先筛选、再变换、最后聚合

scores = [45, 72, 88, 91, 65, 78, 94, 50, 83, 67]

puts "原始成绩: #{scores}"

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

# 使用 lazy 优化（不创建中间数组）
result_lazy = numbers.lazy.map { |n| n ** 2 }.select { |n| n > 25 }.first(3).to_a
puts "numbers.lazy.map { |n| n ** 2 }.select { |n| n > 25 }.first(3)  =>  #{result_lazy}"