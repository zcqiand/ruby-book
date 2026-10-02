grade = "B"

case grade
when "A"
  puts "优秀"
when "B"
  puts "良好"
when "C"
  puts "及格"
when "D", "E"
  puts "需要努力"
else
  puts "未知等级"
end