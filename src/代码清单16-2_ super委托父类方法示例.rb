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

car = Car.new
puts car.describe  # "A vehicle - specifically a car"