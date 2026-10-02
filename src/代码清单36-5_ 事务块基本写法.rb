ActiveRecord::Base.transaction do
  # 在这个代码块里的所有数据库操作
  # 要么全部提交，要么全部回滚
end