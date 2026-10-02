# frozen_string_literal: true

# 场景：展示类的继承结构
# 为什么要展示：继承是面向对象的重要概念

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} 发出了声音"
  end

  def info
    "动物: #{@name}"
  end
end

class Cat < Animal
  def speak
    "#{@name} 喵喵叫: 喵！"
  end

  def purr
    "#{@name} 发出呼噜声..."
  end
end

class Dog < Animal
  def speak
    "#{@name} 汪汪叫: 汪！"
  end

  def wag_tail
    "#{@name} 摇着尾巴"
  end
end

puts "=== 继承演示 ==="
animal = Animal.new("小动物")
cat = Cat.new("咪咪")
dog = Dog.new("旺财")

puts animal.info
puts animal.speak

puts "\n#{cat.info}"
puts cat.speak
puts cat.purr

puts "\n#{dog.info}"
puts dog.speak
puts dog.wag_tail

puts "\n=== 多态演示 ==="
animals = [cat, dog, animal]
animals.each do |a|
  puts "#{a.class}: #{a.speak}"
end