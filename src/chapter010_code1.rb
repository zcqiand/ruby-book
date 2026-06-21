# 方式一：do...end
[1, 2, 3, 4, 5].each do |n|
  puts n * 2
end

# 方式二：大括号
[1, 2, 3, 4, 5].each { |n| puts n * 2 }