# 四种变量对比示例：展示命名规范与作用域差异
# 作用域范围：局部 < 实例 < 类 < 全局

# --- 局部变量：方法内部定义，仅在该方法内有效 ---
def demonstrate_local_scope
  message = "我是局部变量"  # 小写字母或下划线开头
  puts "局部变量: #{message}"
  puts "类型: #{message.class}"
end

# --- 实例变量：属于类实例，每个对象有独立副本 ---
class Product
  def initialize(name, price)
    @name = name      # @开头，在整个实例方法中可用
    @price = price
  end
  
  def display
    # 实例方法中可以访问 @name 和 @price
    puts "实例变量 @name: #{@name}, @price: #{@price}"
    puts "类型: #{@name.class}"
  end
end

# --- 类变量：整个类层级共享，所有实例共用同一份数据 ---
class Config
  @@app_name = "知识管理系统"  # @@开头，类及子类共享
  @@version = "1.0"
  
  def self.show_config
    puts "类变量 @@app_name: #{@@app_name}"
    puts "类变量 @@version: #{@@version}"
  end
  
  def self.update_version(new_version)
    @@version = new_version  # 所有实例看到同一个值
  end
end

# --- 全局变量：程序任何位置都可访问，应尽量避免使用 ---
$global_counter = 0  # $开头

def increment_counter
  $global_counter += 1  # 任何地方都可读写
end

# 执行演示
puts "=" * 50
puts "1. 局部变量演示"
demonstrate_local_scope

puts "\n" + "=" * 50
puts "2. 实例变量演示"
product1 = Product.new("Ruby教程", 99.0)
product2 = Product.new("Python教程", 89.0)
product1.display
product2.display

puts "\n" + "=" * 50
puts "3. 类变量演示"
Config.show_config
Config.update_version("2.0")
puts "修改后:"
Config.show_config

puts "\n" + "=" * 50
puts "4. 全局变量演示"
increment_counter
increment_counter
puts "$global_counter: #{$global_counter}"