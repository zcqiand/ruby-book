module Logging
  def save
    puts "save 被调用了！"
    super  # super 调用的是祖先链上下一个同名方法
  end
end

class User
  prepend Logging

  def save
    # 原有逻辑...
  end
end

user = User.new
user.save  # 先走 Logging 的 save，再走 User 的 save