# 等待用户输入有效数字
input = nil
until input.is_a?(Integer)
  print "请输入一个整数: "
  input = gets.to_i
end