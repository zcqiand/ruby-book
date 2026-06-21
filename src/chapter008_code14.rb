result = loop do
  break "正常退出" if rand > 0.7
  print "."
end
puts "\nloop break 返回值: #{result}"