# 决策问题：设计一个计算器方法，能处理任意个数参数，还能指定默认值
#
# 解决方案：组合使用 *args 可变参数 + 默认值关键字参数
# *args 处理任意个数的位置参数（聚合为数组）
# 关键字参数默认值提供操作类型和初始值的灵活配置
# 这种组合是 Ruby 中最强大的参数处理模式
def calculator(*values, operation: :+, initial: nil)
  # initial == nil 时，使用 identity（单位元）：加法为 0，乘法为 1
  # 这是因为空数组的 reduce 需要初始值才能返回确定结果
  acc = initial.nil? ? 0 : initial

  # inject 遍历 values，每次将 acc 与当前元素按 operation 计算
  # operation 是符号（:+/:-/:*/:/），对应 Proc 或 lambda
  # 相比 case/when 分支，字典查表更快且扩展新操作只需加映射
  ops = {
    :+ => ->(a, b) { a + b },
    :- => ->(a, b) { a - b },
    :* => ->(a, b) { a * b },
    /:/ => ->(a, b) { b != 0 ? a.to_f / b : Float::NAN }  # 防止除零崩溃
  }

  # fetch 操作符安全获取映射，默认返回报错 Proc（触发 ArgumentError）
  func = ops.fetch(operation, -> { raise ArgumentError, "未知操作: #{operation}" })

  values.each { |v| acc = func.call(acc, v) }
  acc
end

# 测试：任意个数参数 + 加法（默认操作）
puts "加法 1+2+3+4+5 = #{calculator(1, 2, 3, 4, 5)}"
puts "乘法 2*3*4 = #{calculator(2, 3, 4, operation: :*)}"
puts "减法 100-30-20 = #{calculator(100, 30, 20, operation: :-)}"
puts "除法 100/2/5 = #{calculator(100, 2, 5, operation: :/)}"

# 指定初始值的累加：相当于 10 + 1 + 2 + 3
puts "带初始值 10+1+2+3 = #{calculator(1, 2, 3, initial: 10)}"

# 指定初始值的乘法：相当于 2 * 3 * 4 * 5
puts "带初始值 2*3*4*5 = #{calculator(3, 4, 5, operation: :*, initial: 2)}"

# 单参数（initial 不为 nil 时，相当于 identity 后的单次操作）
puts "单参数 initial=0 时 42+0 = #{calculator(42, initial: 0, operation: :+)}"

# 空参数（initial 为 nil 时返回 0）
puts "空参数（默认）= #{calculator()}"