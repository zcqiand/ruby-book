# 只打印 1-10 中的奇数
(1..10).each do |n|
  next if n.even?
  print "#{n} "
end
puts