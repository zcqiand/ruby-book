arr = [1, 2, 3, 4, 5]

# 是否包含
arr.include?(3)    # => true

# 索引查询
arr.index(3)       # => 2
arr.find_index(3)   # => 2 (alias)

# 计数
arr.count(3)       # => 1
arr.count { |n| n > 3 }  # => 2