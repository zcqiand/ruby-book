# Ruby 方法默认返回最后一条表达式的值，无需显式 return
# 但显式 return 可以提前退出，这在条件分支多时很有用
def classify(number)
  return "正数" if number > 0   # 满足条件立即返回，后续代码不执行
  return "零" if number == 0
  "负数"                          # 隐式返回最后一条表达式
end

puts classify(5)
puts classify(0)
puts classify(-3)

# 显式 return 可返回多个值（实际是返回数组）
def min_max(*numbers)
  return nil, nil if numbers.empty?
  # .sort 返回排序后的新数组，[0] 和 [-1] 分别是最小和最大值
  # 注意：sort 本身是 O(n log n)，不是 O(n)
  sorted = numbers.sort
  [sorted.first, sorted.last]
end

min_val, max_val = min_max(3, 1, 4, 1, 5, 9, 2, 6)
puts "最小值: #{min_val}, 最大值: #{max_val}"

# 无值情况
result = min_max()
puts "空数组结果: #{result.inspect}"  # inspect 方便查看 nil 值