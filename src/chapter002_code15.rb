# 整数与浮点数运算：展示Ruby的任意精度整数和浮点精度问题
# Ruby整数采用任意精度，不会溢出；浮点数基于IEEE 754标准

puts "=" * 50
puts "1. 整数运算（任意精度）"
# Ruby的Integer类型支持任意大的整数，不会像其他语言那样溢出
large_num = 10**30  # 10的30次方
puts "大整数: #{large_num}"
puts "类型: #{large_num.class}"
puts "加1后: #{large_num + 1}"

# 整数运算保持整数类型
a = 10
b = 3
puts "\n整数除法: #{a} / #{b} = #{a / b} (整数部分)"
puts "整数取模: #{a} % #{b} = #{a % b}"
puts "整数求幂: #{a} ** #{b} = #{a ** b}"

puts "\n" + "=" * 50
puts "2. 浮点数运算和精度问题"
# 浮点数采用IEEE 754双精度，可能出现精度丢失
x = 0.1
y = 0.2
puts "0.1 + 0.2 = #{x + y}"
puts "精确比较失败: #{x + y == 0.3}"  # 返回false

# 使用BigDecimal处理高精度计算
require 'bigdecimal'
bd_result = BigDecimal("0.1") + BigDecimal("0.2")
puts "BigDecimal: 0.1 + 0.2 = #{bd_result}"
puts "BigDecimal精确比较: #{bd_result == BigDecimal("0.3")}"

puts "\n" + "=" * 50
puts "3. 整数与浮点数混合运算"
# 整数与浮点数运算时，整数会自动转换为浮点数
m = 5
n = 2.0
result = m / n  # 整数除以浮点数，整数被提升为浮点数
puts "#{m} / #{n} = #{result}, 类型: #{result.class}"

# 强制转换示例
puts "Integer(10) / Float(3) = #{Integer(10) / Float(3)}"
puts "10.to_f / 3 = #{10.to_f / 3}"

# to_i和to_f方法
pi = 3.14159
puts "\n数值转换:"
puts "#{pi}.to_i = #{pi.to_i} (截断小数)"
puts "#{pi}.round = #{pi.round} (四舍五入)"
puts "#{pi}.floor = #{pi.floor} (向下取整)"
puts "#{pi}.ceil = #{pi.ceil} (向上取整)"