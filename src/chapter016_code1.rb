# Animal 父类
class Animal
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def eat
    "#{@name} is eating"
  end

  def sleep
    "#{@name} is sleeping"
  end
end

# Dog 子类 - is-a 关系：Dog is-an Animal
class Dog < Animal
  attr_accessor :breed

  def initialize(name, age, breed)
    super(name, age)  # 调用父类 initialize
    @breed = breed
  end

  def bark
    "#{@name} says Woof!"
  end

  # 子类扩展：狗会游泳，狗独有自己的行为
  def swim
    "#{@name} is swimming"
  end
end

# 测试
dog = Dog.new("Buddy", 3, "Golden Retriever")
puts dog.eat      # 继承自 Animal
puts dog.sleep    # 继承自 Animal
puts dog.bark     # Dog 自己定义
puts dog.swim     # Dog 自己定义