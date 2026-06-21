class User
  def initialize(name)
    @name = name    # 实例变量：每个 User 对象各有自己的 @name
  end

  def greet
    "你好，我是 #{@name}"
  end
end

alice = User.new("爱丽丝")
bob = User.new("鲍勃")

puts alice.greet   # => 你好，我是爱丽丝
puts bob.greet     # => 你好，我是鲍勃