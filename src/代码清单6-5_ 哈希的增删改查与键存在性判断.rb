user = { name: 'Alice', age: 30, city: 'Beijing' }

# 查：访问键值
user[:name]           # => 'Alice'
user[:country]        # => nil（不存在的键返回nil）
user.fetch(:country)  # => 抛出 KeyError（安全访问）

# 增改：赋值即插入或覆盖
user[:email] = 'alice@example.com'  # 新增
user[:age] = 31                     # 修改

# 删：删除键值对
user.delete(:city)                  # => 'Beijing'
user                                 # => {:name=>'Alice', :age=>31, :email=>'alice@example.com'}

# 键是否存在
user.key?(:name)    # => true
user.has_key?(:name) # => true（别名）
user.value?('Alice') # => true（值是否存在）