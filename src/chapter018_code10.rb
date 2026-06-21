# 示例1：method_missing 拦截演示
# 用途：展示 Ruby 如何拦截所有未定义方法的调用，
#       这是元编程的基础，用于实现动态代理、DSL 等高级特性

class EmptyClass
  # method_missing 是 Ruby 的反射钩子，当调用不存在的方法时自动触发
  # args[0] 是方法名（符号），args[1..-1] 是参数列表
  def method_missing(method_name, *args, **kwargs, &block)
    puts "拦截到未定义方法调用: #{method_name}"
    puts "  参数: #{args.inspect}" unless args.empty?
    puts "  关键字参数: #{kwargs.inspect}" unless kwargs.empty?
    puts "  块: #{block ? '已提供' : '未提供'}" unless block.nil?
    
    # 返回 self 以支持链式调用（类似 ActiveRecord 的查询构建器）
    self
  end
  
  # respond_to_missing? 让 Ruby 的 respond_to? 方法正确报告
  def respond_to_missing?(method_name, include_private = false)
    puts "respond_to_missing? 被调用: #{method_name}"
    true  # 所有方法我们都"能"响应，因为都被 method_missing 拦截了
  end
end

# ========== 演示 ==========
obj = EmptyClass.new

puts "=== 调用不存在的方法 ==="
obj.hello
obj.process_data(1, 2, 3)
obj.configure(setting: "theme", value: "dark")

puts "\n=== 验证 respond_to? 行为 ==="
puts "obj.respond_to?(:hello) => #{obj.respond_to?(:hello)}"

puts "\n=== 链式调用演示 ==="
obj.foo.bar.baz  # method_missing 返回 self，所以可以链式调用