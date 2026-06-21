# 示例2：define_method 动态定义方法
# 用途：在运行时动态创建方法，而不是在类定义时预先声明
#       常用于元编程框架、领域特定语言(DSL)、类宏等场景

class DynamicFactory
  # 这是一个工厂方法，接受方法名和可选的默认值
  def self.create_accessor(method_name, default_value: nil)
    # define_method 是 Module 的私有方法，需要在类上下文中调用
    # 闭包捕获 default_value，实现类似 attr_accessor with default 的效果
    define_method(method_name) do
      # @ 变量是实例变量存储，||= 保证只初始化一次
      @attrs ||= {}
      @attrs[method_name] ||= default_value
    end
    
    # 同时创建 setter 方法
    define_method("#{method_name}=") do |value|
      @attrs ||= {}
      @attrs[method_name] = value
    end
    
    # 返回方法名作为确认
    method_name
  end
  
  # 批量创建多个带默认值的方法
  def self.create_accessors(*method_names, default: nil)
    method_names.each do |name|
      create_accessor(name, default_value: default)
    end
  end
end

# ========== 演示 ==========
puts "=== 动态创建单个访问器 ==="
DynamicFactory.create_accessor(:status, default_value: "pending")
DynamicFactory.create_accessor(:priority, default_value: 0)

obj = DynamicFactory.new
puts "初始 status: #{obj.status}"      # => pending (默认值)
puts "初始 priority: #{obj.priority}"  # => 0 (默认值)

obj.status = "active"
obj.priority = 5
puts "修改后 status: #{obj.status}"    # => active
puts "修改后 priority: #{obj.priority}" # => 5

puts "\n=== 批量创建访问器 ==="
DynamicFactory.create_accessors(:name, :email, :role, default: "未设置")
person = DynamicFactory.new
puts "name: #{person.name}"   # => 未设置
puts "email: #{person.email}" # => 未设置

person.name = "张三"
person.email = "zhang@example.com"
puts "赋值后 name: #{person.name}"   # => 张三
puts "赋值后 email: #{person.email}" # => zhang@example.com

puts "\n=== define_method 与 proc 的关系 ==="
# define_method 接受一个 proc 或 lambda
class BlockDemo
  # 使用 proc 作为方法体
  calculate = ->(x, y) { x ** 2 + y ** 2 }
  define_method(:pythagorean, calculate)
  
  # 使用 lambda 更接近普通方法定义
  define_method(:greet) do |name|
    "你好, #{name}!"
  end
end

demo = BlockDemo.new
puts "勾股定理 (3,4): #{demo.pythagorean(3, 4)}" # => 25
puts "问候: #{demo.greet("世界")}"              # => 你好, 世界!