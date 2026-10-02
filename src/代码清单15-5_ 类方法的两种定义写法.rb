class Dog
  # 写法一：self.method_name
  def self.total_breeds
    puts "狗的品种有178种"
  end

  # 写法二：类名.method_name
  def Dog.species
    puts "狗的学名是 Canis lupus familiaris"
  end
end

Dog.total_breeds     # 直接通过类调用，不需要创建实例
Dog.species