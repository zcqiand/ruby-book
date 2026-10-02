# map: 转换每个元素
squares = [1, 2, 3].map { |x| x ** 2 }

# select: 按条件过滤
evens = [1, 2, 3, 4].select { |x| x.even? }

# reduce: 累计合并
total = [1, 2, 3, 4].reduce(0) { |sum, x| sum + x }