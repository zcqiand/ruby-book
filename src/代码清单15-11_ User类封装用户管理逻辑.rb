# frozen_string_literal: true

# 场景：用户管理系统中的 User 类
# 为什么要用类：类能封装数据与行为，提供清晰的接口

class User
  attr_reader :name, :email

  def initialize(name, email)
    @name = name
    @email = email
    @active = true
    validate_email!
  end

  def activate!
    @active = true
    "#{@name} 的账号已激活"
  end

  def deactivate!
    @active = false
    "#{@name} 的账号已停用"
  end

  def active?
    @active
  end

  def introduce
    if active?
      "大家好，我是 #{@name}，邮箱是 #{@email}"
    else
      "#{@name} 的账号已停用"
    end
  end

  private

  def validate_email!
    unless @email.include?('@') && @email.include?('.')
      raise ArgumentError, "无效的邮箱格式: #{@email}"
    end
  end
end

puts "=== 用户管理演示 ==="
begin
  user1 = User.new("张三", "zhangsan@example.com")
  user2 = User.new("李四", "lisi@example.com")
  user3 = User.new("王五", "invalid-email")

  puts user1.introduce
  puts user2.activate!
  puts user2.introduce
  puts user1.deactivate!
  puts user1.introduce
rescue ArgumentError => e
  puts "创建用户失败: #{e.message}"
end

# 正常流程
user = User.new("赵六", "zhaoliu@example.com")
puts "\n正常创建: #{user.introduce}"