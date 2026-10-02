# 普通哈希访问不存在的键返回nil
h = { a: 1 }
h[:b]  # => nil

# Hash.new(0) 让不存在的键返回0（适合计数场景）
counts = Hash.new(0)
counts[:apple] += 1  # => 1（:apple不存在但返回0，加1后存为1）
counts[:apple] += 1  # => 2