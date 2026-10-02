numbers = [10, 20, 30]

# for 循环
for num in numbers
  print "#{num} "
end
puts

# 等价的 each 实现 —— 与上面完全相同
numbers.each { |num| print "#{num} " }
puts