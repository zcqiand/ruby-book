# ============================================================
# Ruby 从入门到项目实践 - 第16章 代码示例
# 继承与模块(Module)
# Ruby 版本: 3.3+
# ============================================================

# ============================================================
# 示例1: Animal/Dog 继承层次
# 展示 is-a 关系：Dog is-an Animal
# ============================================================

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
puts "=== 示例1: Animal/Dog 继承层次 ==="
dog = Dog.new("Buddy", 3, "Golden Retriever")
puts dog.eat      # 继承自 Animal
puts dog.sleep    # 继承自 Animal
puts dog.bark     # Dog 自己定义
puts dog.swim     # Dog 自己定义

# ============================================================
# 示例2: super 调用父类方法
# 展示 super 不仅可以传参数，还可以用于扩展父类行为
# ============================================================

class Vehicle
  def describe
    "A vehicle"
  end
end

class Car < Vehicle
  def describe
    # 先调用父类实现，再添加自己的内容
    "#{super} - specifically a car"
  end
end

puts "\n=== 示例2: super 调用父类方法 ==="
car = Car.new
puts car.describe  # "A vehicle - specifically a car"

# ============================================================
# 示例3: Module 命名空间
# 展示如何用模块组织相关的类，避免命名冲突
# ============================================================

# 命名空间：把相关的类组织在一起
module Math
  PI = 3.14159

  class Calculator
    def self.add(a, b)
      a + b
    end
  end
end

# 访问命名空间内的常量和类
puts "\n=== 示例3: Module 命名空间 ==="
puts Math::PI              # 3.14159
puts Math::Calculator.add(2, 3)  # 5

# 避免命名冲突：自己写的 String 类
module MyApp
  class String
    def shout
      self.upcase + "!!!"
    end
  end
end

# 不会覆盖 Ruby 内置的 String
puts "hello".class          # String (Ruby 内置)
puts MyApp::String.new("hi").shout  # "HI!!!"

# ============================================================
# 示例4: self.included 回调
# 展示模块被 include 时如何增强宿主类
# ============================================================

module Observable
  # 当模块被 include 时，Ruby 会调用这个方法
  # 宿主类会被传入（这里用 base 表示）
  def self.included(base)
    puts "Observable module was included in #{base}"

    # 动态添加类方法到宿主类
    base.extend(ClassMethods)
  end

  # 这里是实例方法
  def notify_observers(event)
    puts "Notifying: #{event}"
  end

  # 嵌套模块，定义类方法
  module ClassMethods
    def add_observer(obj)
      puts "Adding observer: #{obj}"
    end
  end
end

class Process
  include Observable  # 触发 self.included 回调
end

# 测试
puts "\n=== 示例4: self.included 回调 ==="
process = Process.new
process.notify_observers("task completed")
Process.add_observer(process)
