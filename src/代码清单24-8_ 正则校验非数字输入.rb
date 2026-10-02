print "请输入1到100之间的数字："
input = gets.chomp

unless input.match?(/^\d+$/)
  puts "输入无效，请输入数字"
  next  # 跳回循环开头，重新获取输入
end

guess = input.to_i