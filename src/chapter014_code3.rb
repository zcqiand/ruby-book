begin
  result = 10 / user_input
rescue ZeroDivisionError
  puts "除数不能为零"
rescue StandardError => e
  puts "出错了: #{e.message}"
end