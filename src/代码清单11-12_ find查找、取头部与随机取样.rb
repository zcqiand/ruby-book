
# find：查找第一个满足条件的元素，找到返回元素，否则返回 nil
first_divisible_by_3 = numbers.find { |n| n % 3 == 0 }
puts "numbers.find { |n| n % 3 == 0 }  =>  #{first_divisible_by_3}"

# first：获取前 N 个元素
first_3 = numbers.first(3)
puts "numbers.first(3)  =>  #{first_3}"

# take：提取前 N 个元素（与 first 功能相同）
taken = numbers.take(4)
puts "numbers.take(4)  =>  #{taken}"

# sample：随机选取元素（不重复）
random_sample = numbers.sample(3)
puts "numbers.sample(3)  =>  #{random_sample}"

# 随机选取单个元素
single_random = numbers.sample
puts "numbers.sample  =>  #{single_random}"

# find_all 是 select 的别名
multiples_of_2 = numbers.find_all { |n| n % 2 == 0 }
puts "numbers.find_all { |n| n % 2 == 0 }  =>  #{multiples_of_2}"