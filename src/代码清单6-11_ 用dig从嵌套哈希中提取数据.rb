# 从嵌套结构中提取
record = { user: { name: 'Alice', age: 30 }, scores: [95, 88, 92] }
name = record.dig(:user, :name)
scores = record[:scores]
top_score = scores.max
puts "#{name}最高分: #{top_score}"