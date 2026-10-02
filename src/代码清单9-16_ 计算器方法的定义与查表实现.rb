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