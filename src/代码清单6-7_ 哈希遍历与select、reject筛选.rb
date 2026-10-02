scores = { alice: 95, bob: 72, carol: 88, dave: 55 }

# each：遍历所有键值对
puts "所有成绩："
scores.each { |name, score| puts "#{name}: #{score}" }
# 输出: alice: 95\n bob: 72\n carol: 88\n dave: 55

# each_key：只遍历键
puts "\n所有人名："
scores.each_key { |name| puts name }

# each_value：只遍历值
puts "\n所有分数："
scores.each_value { |score| puts score }

# select：筛选
passing = scores.select { |name, score| score >= 80 }
# => {:alice=>95, :carol=>88}

# reject：排除
failing = scores.reject { |name, score| score >= 80 }
# => {:bob=>72, :dave=>55}