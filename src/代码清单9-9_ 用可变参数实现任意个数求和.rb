def sum(*numbers)
  total = 0
  numbers.each { |n| total += n }
  total
end

puts sum(1, 2, 3)           # 输出: 6
puts sum(10, 20, 30, 40, 50) # 输出: 150
puts sum                    # 输出: 0