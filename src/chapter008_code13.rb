counter = 0
max_attempts = 5

loop do
  counter += 1
  puts "尝试 ##{counter}"
  
  if counter >= max_attempts
    puts "达到最大尝试次数，退出"
    break
  end
end