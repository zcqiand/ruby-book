prc = Proc.new { |a, b| a + b }
lam = lambda { |a, b| a + b }

prc.call(1, 2, 3)  # 不报错，第三个参数被忽略
# => 3

lam.call(1, 2, 3)  # 报错！ArgumentError
# => wrong number of arguments (given 3, expected 2)