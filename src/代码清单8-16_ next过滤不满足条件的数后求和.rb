# 计算 1-100 中不能被 3 和 5 整除的数之和
sum = 0
(1..100).each do |n|
  next if n % 3 == 0 || n % 5 == 0
  sum += n
end
puts "1-100 中不能被3或5整除的数之和: #{sum}"