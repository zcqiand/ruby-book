# 模拟最多重试3次
attempts = 0
max_retries = 3

5.times do |i|
  attempts += 1
  print "第 #{attempts} 次尝试..."
  
  if attempts < max_retries * 5  # 模拟成功条件
    puts " 失败，重试"
    retry
  else
    puts " 成功!"
  end
end