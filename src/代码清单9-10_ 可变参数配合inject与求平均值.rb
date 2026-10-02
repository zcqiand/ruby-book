# *args 将所有剩余位置参数收集为一个数组
# 这使得方法可以接受任意个数参数，无需重载
# Ruby 2.7+ 支持在参数列表中间使用 *args，但收集的是其后的参数
def sum(*numbers)
  # inject 是 Ruby 的折叠操作，等价于 reduce
  # 相比手动遍历，inject 更声明式，代码更简洁
  numbers.inject(0) { |acc, n| acc + n }
end

# 调用时可以传任意个数参数
puts "单个参数: #{sum(5)}"
puts "两个参数: #{sum(3, 4)}"
puts "五个参数: #{sum(1, 2, 3, 4, 5)}"
puts "无参数（返回 0）: #{sum()}"

# 可变参数常用于实现聚合操作
def average(*nums)
  return nil if nums.empty?
  # sum / count，一次遍历完成两个聚合操作
  # 注意：浮点除法需要 .to_f，否则整数除法会截断
  nums.sum.to_f / nums.size
end

puts "平均值 1..10: #{average(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)}"