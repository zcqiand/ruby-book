begin
  age = gets.to_i
  birth_year = 2026 - age
  puts "你出生于 #{birth_year} 年"
rescue
  puts "出错了，请输入有效数字"
end