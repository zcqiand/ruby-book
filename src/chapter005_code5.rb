# 基础 each 遍历
fruits = ['苹果', '香蕉', '橙子']
puts "=== 基础 each 遍历 ==="
fruits.each { |fruit| puts "我喜欢吃: #{fruit}" }

# each_with_index（同时获取元素和索引）
# 需要索引时比 each 更高效，无需手动维护计数器
puts "\n=== 带索引遍历 ==="
fruits.each_with_index { |fruit, idx| puts "#{idx + 1}. #{fruit}" }

# 反向遍历（reverse_each）
# 当需要从末尾开始处理时，比先 reverse 再 each 更直观
puts "\n=== 反向遍历 ==="
fruits.reverse_each { |fruit| puts "倒序: #{fruit}" }

# each 与条件结合（使用 break/next 控制流程）
puts "\n=== each + 控制流程 ==="
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numbers.each do |n|
  next if n.even?  # 跳过偶数
  print "#{n} "
  break if n > 5   # 遇到大于5的奇数停止
end
puts
# 输出: 1 3 5