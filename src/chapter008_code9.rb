# 0 到 10，步长为 2
0.step(10, 2) { |n| print "#{n} " }
puts

# 浮点数也可以
0.0.step(1.0, 0.3) { |f| print "#{f.round(1)} " }
puts