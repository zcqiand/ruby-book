# frozen_string_literal: true

# 场景：定义一个 Dog 类，展示类的完整结构
# 为什么要完整：Dog 类是面向对象入门的经典案例

class Dog
  # 类常量
  LEGS_COUNT = 4

  # 类变量 - 所有实例共享
  @@count = 0

  # 构造方法 - 创建对象时自动调用
  def initialize(name, breed: "田园犬")
    @name = name        # 实例变量 - 每个对象独立
    @breed = breed
    @hungry = true
    @@count += 1        # 更新类变量
  end

  # 实例方法 - 通过对象调用
  def bark
    "#{@name} 汪汪叫: 汪！汪！"
  end

  def eat
    @hungry = false
    "#{@name} 正在吃狗粮..."
  end

  def hungry?
    @hungry
  end

  def info
    "#{@name} (#{@breed}) - #{hungry? ? '饿了' : '吃饱了'}"
  end

  # 类方法 - 通过类本身调用
  def self.count
    "目前共有 #{@@count} 只狗"
  end

  def self.legs
    "每只狗有 #{LEGS_COUNT} 条腿"
  end
end

puts "=== Dog 类演示 ==="
dog1 = Dog.new("旺财")
dog2 = Dog.new("小白", breed: "萨摩耶")

puts dog1.bark
puts dog2.bark
puts dog1.eat
puts dog2.info
puts dog1.hungry?
puts dog2.hungry?

puts "\n=== 类方法演示 ==="
puts Dog.count
puts Dog.legs