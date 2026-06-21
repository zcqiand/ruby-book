class User
  @@user_count = 0  # 类变量：所有 User 实例共享

  def initialize(name)
    @name = name
    @@user_count += 1
  end

  def self.total
    "用户总数：#{@@user_count}"
  end
end

User.new("小明")
User.new("小红")
puts User.total  # => 用户总数：2