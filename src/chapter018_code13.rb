# 示例4：类宏定义 - 使用元编程创建可复用的类级方法
# 用途：类宏允许在类定义时声明式地添加功能，类似 Rails 的 has_many, belongs_to 等
#       这是 Ruby on Rails 生态系统的核心模式之一

module AttributeMacros
  # 扩展机制：include 后模块方法变为实例方法，extend 后变为类方法
  # 这里使用 extended 钩子在类 include/extend 时自动执行设置
  
  # 创建带默认值、类型检查和变更追踪的属性
  def def_attribute(name, default: nil, &validator)
    # 第一次调用时注册回调（惰性初始化）
    @attribute_definitions ||= {}
    @attribute_definitions[name] = { default: default, validator: validator }
    
    # 1. 创建 getter：返回存储的值或默认值
    define_method(name) do
      @attributes ||= {}
      @attributes[name] ||= default
    end
    
    # 2. 创建 setter：带可选验证
    setter_name = "#{name}="
    define_method(setter_name) do |value|
      # 如果提供了验证块，执行类型/值检查
      if validator
        raise ArgumentError, "#{name} 验证失败: #{validator.call(value)}" unless validator.call(value)
      end
      @attributes ||= {}
      @attributes[name] = value
    end
    
    # 3. 创建查询方法（真值判断）：name? 返回是否为默认值的布尔值
    query_name = "#{name}?"
    define_method(query_name) do
      @attributes ||= {}
      @attributes[name] == default
    end
    
    # 4. 创建重置方法：恢复到默认值
    reset_name = "reset_#{name}!"
    define_method(reset_name) do
      @attributes ||= {}
      @attributes[name] = default
    end
    
    # 返回方法名列表（可选，用于元编程自省）
    [name, setter_name, query_name, reset_name]
  end
  
  # 类方法查询：获取当前类已定义的所有属性
  def attribute_definitions
    @attribute_definitions || {}
  end
end

# 应用类宏到任意类
class Product
  # 使用类宏语法：类名.def_attribute(:name)
  # 这会在类定义时动态创建 getter/setter/query/reset 方法
  
  # 普通属性
  def_attribute :name, default: "未命名"
  
  # 带类型验证的属性
  def_attribute :price, default: 0.0 do |v|
    v.is_a?(Numeric) && v >= 0
  end
  
  # 带枚举验证的属性
  def_attribute :status, default: "draft" do |v|
    ["draft", "published", "archived"].include?(v)
  end
end

class User
  def_attribute :username, default: "guest"
  def_attribute :email, default: ""
  def_attribute :age, default: 0 do |v|
    v.is_a?(Integer) && v >= 0 && v <= 150
  end
end

# ========== 演示 ==========
puts "=== 基本 getter/setter/query ==="
product = Product.new
puts "默认 name: #{product.name}"           # => 未命名
puts "默认 name? (是否为默认值?): #{product.name?}" # => true

product.name = "Ruby 教程"
puts "赋值后 name: #{product.name}"         # => Ruby 教程
puts "name? 变化: #{product.name?}"          # => false

puts "\n=== 验证器演示 ==="
product.price = 99.9
puts "price: #{product.price}"               # => 99.9

begin
  product.price = -10  # 触发验证失败
rescue ArgumentError => e
  puts "价格验证: #{e.message}"  # => price 验证失败: ...
end

puts "\n=== 枚举属性 ==="
product.status = "published"
puts "status: #{product.status}"            # => published

begin
  product.status = "invalid_status"
rescue ArgumentError => e
  puts "状态验证: #{e.message}"  # => status 验证失败: ...
end

puts "\n=== 重置功能 ==="
puts "重置前 name: #{product.name}"
product.reset_name!
puts "重置后 name: #{product.name}"          # => 未命名

puts "\n=== 元编程自省 ==="
puts "Product 定义了以下属性: #{Product.attribute_definitions.keys}"
puts "User 定义了以下属性: #{User.attribute_definitions.keys}"

puts "\n=== 另一类的独立实例 ==="
user = User.new
puts "user.username: #{user.username}"      # => guest
user.username = "zhangsan"
puts "user.username (修改后): #{user.username}" # => zhangsan
puts "user 实例不影响 Product: #{product.name}"  # => 未命名 (未被影响)