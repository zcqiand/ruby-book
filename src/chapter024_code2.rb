# chapter24_v1_single_round.rb
# 单局版猜数字游戏：展示最核心的随机数 + 输入 + 判断逻辑

secret = Random.rand(1..100)  # 生成 1-100 的秘密数字
attempts = 0

puts "我已经想好了一个 1-100 之间的数字，来猜猜看！"

loop do
  print "请输入你的猜测: "
  guess = gets.chomp.to_i  # chomp 去掉换行符，to_i 转整数
  attempts += 1

  case
  when guess < secret
    puts "太小了！"
  when guess > secret
    puts "太大了！"
  else
    puts "恭喜你，猜对了！你用了 #{attempts} 次。"
    break  # 猜对后退出循环
  end
end