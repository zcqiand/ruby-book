# -*- coding: utf-8 -*-
# 四种变量对比示例

# ========== 局部变量 ==========
# 以小写字母或下划线开头,只在定义它的代码块或方法内部有效
count = 10
_temp = "临时数据"
user_name = "Alice"

puts "=== 局部变量 ==="
puts "count = #{count}"
puts "_temp = #{_temp}"
puts "user_name = #{user_name}"

# ========== 实例变量 ==========
# 以 @ 开头,属于类实例,每个对象有独立的副本
class User
  def initialize(name)
    @name = name          # 实例变量:每个对象独立
    @age = 25
  end

  def display
    puts "实例变量: @name = #{@name}, @age = #{@age}"
  end
end

puts "\n=== 实例变量 ==="
user1 = User.new("Alice")
user2 = User.new("Bob")
user1.display
user2.display

# ========== 类变量 ==========
# 以 @@ 开头,在整个类及其子类中共享
class Counter
  @@total_count = 0  # 类变量:所有实例共享

  def initialize
    @@total_count += 1
  end

  def self.total_count
    @@total_count
  end
end

puts "\n=== 类变量 ==="
c1 = Counter.new
c2 = Counter.new
c3 = Counter.new
puts "已创建 #{Counter.total_count} 个计数器实例"

# ========== 全局变量 ==========
# 以 $ 开头,程序任何地方都可以访问
$LOAD_PATH.each { |p| puts "Load path: #{p}" } if $LOAD_PATH.length < 5
$PROGRAM_NAME = "example_program"
$global_var = "全局数据"

puts "\n=== 全局变量 ==="
puts "$PROGRAM_NAME = #{$PROGRAM_NAME}"
puts "$global_var = #{$global_var}"

# ========== 作用域对比 ==========
puts "\n=== 变量前缀规则总结 ==="
puts "局部变量: 小写字母或下划线开头 (count, _temp, user_name)"
puts "实例变量: @ 开头 (@name, @age)"
puts "类变量: @@ 开头 (@@total_count)"
puts "全局变量: $ 开头 ($LOAD_PATH, $PROGRAM_NAME)"