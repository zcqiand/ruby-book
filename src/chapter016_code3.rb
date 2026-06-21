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