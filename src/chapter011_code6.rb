# Array 和 Range 默认包含 Enumerable
(1..10).class              # => Range
[1, 2, 3].class             # => Array

# Enumerable 方法统统可用
(1..5).map { |x| x * 2 }   # => [2, 4, 6, 8, 10]
[3, 1, 4, 1, 5].sort       # => [1, 1, 3, 4, 5]