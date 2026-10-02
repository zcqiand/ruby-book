# 简化模拟 ActiveRecord 的 find_by
def find_by(conditions)
  results = database_select(conditions)

  if block_given?
    results.select! { |record| yield(record) }
  end

  results.first
end

# 用法：不传块，用默认搜索
users = find_by(name: "张三")

# 用法：传块，进一步筛选
users = find_by(status: "active") { |u| u.age > 18 }