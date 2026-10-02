File.open("log.txt") do |file|
  file.each_line do |line|
    puts "正在处理: #{line}"
  end
end