def greet
  puts "开始执行方法"
  yield          # 召唤块，块执行完后继续
  puts "方法执行完毕"
end

greet do
  puts "块的逻辑在这里！"
end