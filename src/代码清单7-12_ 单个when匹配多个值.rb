animal = "cat"

case animal
when "dog", "cat", "bird"
  puts "这是常见的宠物"
when "lion", "tiger", "bear"
  puts "这是野生动物"
else
  puts "未知的动物类型"
end