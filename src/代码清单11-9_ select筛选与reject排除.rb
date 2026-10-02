
# select：保留满足条件的元素
evens = numbers.select { |n| n.even? }
puts "numbers.select { |n| n.even? }  =>  #{evens}"

# reject：排除满足条件的元素（select 的相反操作）
odd_greater_than_5 = numbers.reject { |n| n <= 5 || n.even? }
puts "numbers.reject { |n| n <= 5 || n.even? }  =>  #{odd_greater_than_5}"