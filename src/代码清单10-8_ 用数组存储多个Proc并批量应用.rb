# 场景：需要对数组做多次不同转换
numbers = [1, 2, 3, 4, 5]

# 把转换规则存起来
rules = [
  proc { |x| x * 2 },
  proc { |x| x + 100 },
  proc { |x| x ** 2 }
]

# 应用每条规则
rules.each do |rule|
  numbers = numbers.map(&rule)  # & 把 Proc 转回块
  puts numbers.inspect
end