# frozen_string_literal: true

# 场景：用户在计算器类中执行除法运算
# 为什么要捕获 ZeroDivisionError：Ruby 会自动抛出该异常，若不处理会导致程序崩溃
# 这里的模式是 begin/rescue/else/ensure 标准结构

class Calculator
  def divide(dividend, divisor)
    begin
      result = dividend.to_f / divisor.to_f
    rescue ZeroDivisionError => e
      # 记录日志而非直接返回 nil，利于调试
      warn "警告：除数不能为零 (#{e.message})"
      return nil
    rescue StandardError => e
      warn "运算错误：#{e.class} - #{e.message}"
      return nil
    else
      puts "计算成功，结果为 #{result}"
      result
    end
  end
end

calc = Calculator.new

puts "=== 测试用例 ==="
puts "10 / 2 = #{calc.divide(10, 2).inspect}"
puts "5 / 0 = #{calc.divide(5, 0).inspect}"
puts "'hello' / 2 = #{calc.divide('hello', 2).inspect}"