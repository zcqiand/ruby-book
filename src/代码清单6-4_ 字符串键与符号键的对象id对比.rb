# 字符串键：每次都是新对象
{ 'name' => 'Alice' }['name'].object_id  # 每次不同
{ 'name' => 'Alice' }['name'].object_id  # 又是新对象

# 符号键：共享同一个对象
{ name: 'Alice' }[:name].object_id       # 相同
{ name: 'Alice' }[:name].object_id       # 还是同一个