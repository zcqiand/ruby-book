# 示例3：动态代理DSL - 模拟 ActiveRecord 的 where 风格接口
# 用途：展示如何结合 method_missing 和 define_method 构建流畅接口(Fluent API)
#       这种模式广泛用于 ORM 查询构建器、HTTP 客户端等场景

class Query
  # 内部存储模型名和查询条件
  def initialize(model)
    @model = model
    @conditions = []
    @limit_value = nil
  end
  
  # where 方法：显式定义，支持链式调用
  def where(field, value)
    @conditions << { field: field, value: value }
    self  # 返回 self 支持链式调用
  end
  
  # limit 方法：显式定义
  def limit(n)
    @limit_value = n
    self
  end
  
  # method_missing 实现隐式字段查询：
  # 当调用 .name("张三") 时，自动转换为 .where(:name, "张三")
  # 这模仿了 ActiveRecord 的 where(name: "张三") 简化写法
  def method_missing(method_name, *args, **kwargs, &block)
    if args.length == 1 && kwargs.empty? && !block
      # 解释：.name("张三") => where(:name, "张三")
      # 隐式方法转发，减少样板代码
      @conditions << { field: method_name, value: args[0] }
      self
    elsif kwargs.any?
      # 处理 kwargs: .name(email: "x", age: 20) => where(:name, x).where(:email, 20)
      kwargs.each do |k, v|
        @conditions << { field: k, value: v }
      end
      self
    else
      super  # 未知调用交给 Ruby 处理
    end
  end
  
  # respond_to_missing? 确保 respond_to? 正确工作
  def respond_to_missing?(method_name, include_private = false)
    true
  end
  
  # 执行查询（模拟）
  def execute
    result = "#{@model} WHERE "
    conditions_str = @conditions.map do |c|
      "#{c[:field]} = #{c[:value].inspect}"
    end.join(" AND ")
    result += conditions_str
    result += " LIMIT #{@limit_value}" if @limit_value
    result
  end
end

# 模型类：使用元编程自动生成查询方法
class User
  # 类方法返回 Query 对象，支持 .where, .limit 及隐式字段查询
  def self.query
    Query.new("users")
  end
  
  # 动态为每个字段生成查询方法（可选的优化）
  # 这里使用 define_method 批量创建
  [:id, :name, :email, :age, :status].each do |field|
    define_method(field) { nil }  # 占位方法
  end
end

# ========== 演示 ==========
puts "=== 基础链式调用 ==="
query1 = User.query.where(:status, "active").where(:age, 25)
puts query1.execute
# => users WHERE status = "active" AND age = 25

puts "\n=== 隐式字段查询（DSL核心） ==="
# method_missing 拦截：.name("张三") 被转换为 .where(:name, "张三")
query2 = User.query.name("张三").email("zhang@example.com")
puts query2.execute
# => users WHERE name = "张三" AND email = "zhang@example.com"

puts "\n=== 混合使用显式和隐式 ==="
query3 = User.query.status("active").limit(10)
puts query3.execute
# => users WHERE status = "active" LIMIT 10

puts "\n=== kwargs 语法支持 ==="
query4 = User.query.name("李四", email: "li@example.com", age: 30)
puts query4.execute
# => users WHERE name = "李四" AND email = "li@example.com" AND age = 30

puts "\n=== 完整链式示例 ==="
query5 = User.query.status("inactive").name("王五").limit(5)
puts query5.execute
# => users WHERE status = "inactive" AND name = "王五" LIMIT 5