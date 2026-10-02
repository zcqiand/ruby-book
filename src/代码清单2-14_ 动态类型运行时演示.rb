# 动态类型演示：Ruby中变量类型由值在运行时决定
# 同一变量可以先后保存不同类型的值，.class揭示当前类型

# 变量无需声明类型，直接赋值即可创建
data = 42              # 初始赋值整数
puts "第1次赋值: #{data}, 类型: #{data.class}"

data = "四十二"         # 重新赋值为字符串，Ruby允许这样做
puts "第2次赋值: #{data}, 类型: #{data.class}"

data = 3.14             # 再次赋值为浮点数
puts "第3次赋值: #{data}, 类型: #{data.class}"

data = [1, 2, 3]        # 也可以是数组
puts "第4次赋值: #{data}, 类型: #{data.class}"

# 利用动态类型特性：同一变量可作为不同类型使用
def process(item)
  # Ruby中不需要类型检查，直接操作
  case item
  when Integer
    item * 2  # 整数翻倍
  when String
    item.reverse  # 字符串反转
  when Float
    "%.2f" % item  # 浮点数格式化
  when Array
    item.sum  # 数组求和
  end
end

puts "\n" + "=" * 50
puts "动态类型在方法中的表现:"
puts "整数处理: process(10) => #{process(10)}"
puts "字符串处理: process('hello') => #{process('hello')}"
puts "浮点数处理: process(2.5) => #{process(2.5)}"
puts "数组处理: process([1,2,3,4,5]) => #{process([1,2,3,4,5])}"

# 类型查询方法
value = 100
puts "\n" + "=" * 50
puts "类型查询方法:"
puts "100.is_a?(Integer) => #{value.is_a?(Integer)}"
puts "100.is_a?(Numeric) => #{value.is_a?(Numeric)}"
puts "100.respond_to?(:next) => #{value.respond_to?(:next)}"