# chapter19_tdd_factorial.rb
# TDD（测试驱动开发）演示 - 红绿重构循环实现阶乘函数
# TDD 核心：先写失败的测试（红），再写通过的实现（绿），最后重构优化

require 'minitest/autorun'

# ============================================================
# 阶段一：RED（红）- 先写测试，此时实现不存在，测试应该失败
# 为什么先写测试：明确需求边界，避免过度设计
# ============================================================

# 阶乘定义：
# 0! = 1
# n! = n * (n-1)!  (n > 0)
# 例如：5! = 5 * 4 * 3 * 2 * 1 = 120

describe Factorial do
  describe '.calculate' do
    it '0! 等于 1（基础情形）' do
      assert_equal 1, Factorial.calculate(0)
    end

    it '1! 等于 1' do
      assert_equal 1, Factorial.calculate(1)
    end

    it '5! 等于 120' do
      assert_equal 120, Factorial.calculate(5)
    end

    it '10! 等于 3628800' do
      assert_equal 3_628_800, Factorial.calculate(10)
    end

    it '处理负数时抛出 ArgumentError' do
      assert_raises(ArgumentError) do
        Factorial.calculate(-1)
      end
    end
  end
end

# ============================================================
# 阶段二：GREEN（绿）- 实现代码让测试通过
# 初始实现：简单直接，满足当前测试即可
# ============================================================

class Factorial
  # 使用递归实现，简洁直观
  # 为什么用递归：数学定义本身就是递归的，代码与数学定义一致
  def self.calculate(n)
    raise ArgumentError, "阶乘只定义于非负整数" if n < 0

    # 递归终止条件：0! = 1
    return 1 if n == 0 || n == 1

    # 递归调用：n! = n * (n-1)!
    n * calculate(n - 1)
  end
end

# ============================================================
# 阶段三：REFACTOR（重构）- 优化代码结构
# 重构目标：保持功能不变，提升性能或可读性
# ============================================================

# 重构版本：使用迭代消除递归调用栈开销
# 为什么重构为迭代：递归在 n 较大时可能引发栈溢出，迭代更高效
class Factorial
  def self.calculate(n)
    raise ArgumentError, "阶乘只定义于非负整数" if n < 0

    # 特殊情况直接返回，避免循环开销
    return 1 if n <= 1

    # 迭代实现：从 1 累乘到 n
    result = 1
    (2..n).each do |i|
      result *= i
    end
    result
  end
end

# ============================================================
# 测试通过后，添加更多边界测试用例验证重构正确性
# ============================================================

describe Factorial do
  describe '.calculate (迭代实现)' do
    it '正确计算小数值阶乘' do
      assert_equal 1, Factorial.calculate(0)
      assert_equal 1, Factorial.calculate(1)
      assert_equal 2, Factorial.calculate(2)
      assert_equal 6, Factorial.calculate(3)
      assert_equal 24, Factorial.calculate(4)
    end

    it '正确计算较大值阶乘' do
      assert_equal 479001600, Factorial.calculate(12)
    end

    it '负数抛出 ArgumentError' do
      assert_raises(ArgumentError) { Factorial.calculate(-5) }
    end
  end
end