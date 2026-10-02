# chapter19_minitest_spec_style.rb
# Minitest Spec 风格示例 - 演示 describe/it 语法块、before/after 钩子及多种断言

require 'minitest/autorun'

# 待测试类：简单计算器
# 为什么这样设计：一个类包含多个相关方法，便于用 describe 块分组测试
class Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)
    raise ZeroDivisionError, "除数不能为零" if b == 0
    a / b.to_f
  end

  def square(n)
    n ** 2
  end
end

# Spec 风格测试套件
# 为什么用 describe 块分组：相关测试逻辑聚合在一起，提高可读性和可维护性
describe Calculator do
  # before 钩子：每个测试用例执行前都会运行
  # 为什么用实例变量：在多个测试间共享测试数据，避免重复创建
  before do
    @calc = Calculator.new
    @test_data = { a: 10, b: 3 }
  end

  # after 钩子：每个测试用例执行后运行（此处用于清理）
  after do
    # 清理工作（关闭文件句柄、数据库连接等）
  end

  describe '#add' do
    it '返回两个数的和' do
      # assert_equal：最常用的断言，验证期望值与实际值相等
      assert_equal 13, @calc.add(@test_data[:a], @test_data[:b])
    end

    it '处理负数相加' do
      assert_equal -5, @calc.add(2, -7)
    end

    it '处理零值' do
      assert_equal 10, @calc.add(10, 0)
    end
  end

  describe '#subtract' do
    it '返回两个数的差' do
      assert_equal 7, @calc.subtract(@test_data[:a], @test_data[:b])
    end

    it '处理结果为负数的情况' do
      assert_equal -5, @calc.subtract(3, 8)
    end
  end

  describe '#multiply' do
    it '返回两个数的积' do
      assert_equal 30, @calc.multiply(@test_data[:a], @test_data[:b])
    end

    it '任何数乘以零都为零' do
      assert_equal 0, @calc.multiply(100, 0)
    end
  end

  describe '#divide' do
    it '返回两个数的商（浮点数）' do
      # assert_in_delta：浮点数比较时使用，允许小幅误差
      assert_in_delta 3.33, @calc.divide(10, 3), 0.01
    end

    it '抛出 ZeroDivisionError 当除数为零' do
      # assert_raises：验证代码块是否抛出指定异常
      assert_raises(ZeroDivisionError) do
        @calc.divide(10, 0)
      end
    end
  end

  describe '#square' do
    it '返回数的平方' do
      assert_equal 100, @calc.square(10)
    end

    it '处理零的平方' do
      assert_equal 0, @calc.square(0)
    end

    it '处理负数的平方（结果为正）' do
      assert_equal 16, @calc.square(-4)
    end
  end
end