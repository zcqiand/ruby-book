# chapter19_minitest_assertions.rb
# Minitest 断言方法详解 - 展示各种 assert/refute 方法的用法

require 'minitest/autorun'

describe 'Minitest 断言方法演示' do
  # assert - 基本断言，表达式为真则通过
  it 'assert 基本用法' do
    assert 1 + 1 == 2
    assert [1, 2, 3].length == 3
    assert({}.empty?)
  end

  # refute - assert 的反义，表达式为假则通过
  it 'refute 基本用法' do
    refute 1 + 1 == 3
    refute nil
    refute [].any?
  end

  # assert_equal - 值相等断言，比较两个对象的值（使用 ==）
  it 'assert_equal 用法' do
    assert_equal 42, 21 * 2
    assert_equal 'hello', 'hel' + 'lo'
    assert_equal [1, 2, 3], [1, 2, 3]
  end

  # assert_nil - 验证值为 nil
  it 'assert_nil 用法' do
    obj = nil
    assert_nil obj
    assert_nil [1, 2, 3].find { |x| x > 10 }
  end

  # assert_raises - 验证代码块抛出指定异常
  it 'assert_raises 用法' do
    assert_raises(ZeroDivisionError) { 1 / 0 }
    assert_raises(ArgumentError) { Integer('abc') }
  end

  # assert_instance_of - 验证对象是指定类的实例
  it 'assert_instance_of 用法' do
    assert_instance_of String, 'hello'
    assert_instance_of Integer, 42
    assert_instance_of Array, [1, 2, 3]
  end

  # assert_kind_of - 验证对象是指定类或其子类实例
  it 'assert_kind_of 用法' do
    assert_kind_of Numeric, 42
    assert_kind_of Object, 'string'
    assert_kind_of Enumerable, [1, 2]
  end

  # assert_match - 验证字符串匹配正则表达式
  it 'assert_match 用法' do
    assert_match /hello/, 'hello world'
    assert_match(/\d+/, 'room 302')
  end

  # assert_in_delta - 浮点数近似比较，允许误差范围
  it 'assert_in_delta 用法' do
    assert_in_delta 1.0, 1.0001, 0.001
    assert_in_delta 3.14, 3.14159, 0.001
  end

  # assert_operator - 验证表达式使用指定操作符
  it 'assert_operator 用法' do
    assert_operator 5, :>, 3
    assert_operator 10, :<=, 10
    assert_operator 'abc', :<, 'def'
  end

  # assert_throws - 验证代码块是否抛出指定 symbol
  it 'assert_throws 用法' do
    assert_throws :exit do
      throw :exit
    end
  end
end