outer = true

while outer
  secret = rand(1..100)
  puts "新一局开始，秘密数字已生成（你自己看不到）"

  while true
    print "请输入猜测："
    guess = gets.to_i

    if guess == secret
      puts "恭喜猜对了！"
      break  # 这里只跳出内层while，不能跳出外层
    elsif guess > secret
      puts "太大了"
    else
      puts "太小了"
    end
  end

  print "再来一局？(y/n)："
  response = gets.chomp
  if response != 'y'
    puts "再见！"
    break  # 这里才跳出外层循环
  end
end