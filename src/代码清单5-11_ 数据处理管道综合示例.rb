# 示例数据：用户年龄数组
ages = [23, 19, 45, 17, 32, 88, 12, 65, 7]

# 场景：找出成年用户 → 取年龄 → 乘2 → 排序
result = ages.select { |age| age >= 18 }
              .map { |age| age * 2 }
              .sort
puts "成年年龄翻倍并排序: #{result}"
# => [38, 46, 64, 90, 130, 176]

# 一行搞定成年用户筛选（呼应 decision_question）
adults_one_liner = ages.select { |age| age >= 18 }
puts "成年用户: #{adults_one_liner}"
# => [23, 19, 45, 32, 88, 65]

# 复杂链式：去重 → 筛选 → 映射 → 求和
# 链式调用可组合出强大数据管道，减少中间变量
scores = [95, 82, 95, 78, 88, 82, 91, 95, 78]
total = scores.uniq
              .select { |s| s >= 85 }
              .map { |s| s * 1.1 }  # 加10分
              .sum
puts "高分去重加分求和: #{total.round(1)}"
# => 301.4

# 统计类方法组合
puts "成年人数: #{ages.select { |a| a >= 18 }.count}"
puts "成年年龄总和: #{ages.select { |a| a >= 18 }.sum}"
puts "最大成年年龄: #{ages.select { |a| a >= 18 }.max}"
puts "最小成年年龄: #{ages.select { |a| a >= 18 }.min}"

# partition 分组（同时得到满足和不满足条件的两组）
children, adults_partitioned = ages.partition { |age| age < 18 }
puts "未成年: #{children}"
puts "成年: #{adults_partitioned}"
# => 未成年: [17, 12, 7]
# => 成年: [23, 19, 45, 32, 88, 65]