class Dog
  def initialize(name, breed)
    @name = name          # @name 是实例变量
    @breed = breed
    puts "#{@name} 来啦！"
  end

  def bark
    puts "#{@name} 吠叫：汪汪！"
  end
end

my_dog = Dog.new("旺财", "柯基")
# 输出：旺财 来啦！
my_dog.bark
# 输出：旺财 吠叫：汪汪！