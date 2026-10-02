# chapter19_string_helper_spec.rb
# 综合示例：测试 StringHelper 类，展示更多断言类型和边界情况处理

require 'minitest/autorun'

# 待测试类：字符串工具类
class StringHelper
  # 反转字符串
  def self.reverse_string(str)
    str.reverse
  end

  # 判断是否为回文（正读反读相同）
  def self.palindrome?(str)
    return false if str.nil? || str.empty?
    clean = str.downcase.gsub(/\s+/, '')
    clean == clean.reverse
  end

  # 统计单词数量
  def self.word_count(str)
    return 0 if str.nil? || str.strip.empty?
    str.split(/\s+/).length
  end

  # 首字母大写
  def self.capitalize_words(str)
    return '' if str.nil? || str.empty?
    str.split.map(&:capitalize).join(' ')
  end

  # 移除重复字符
  def self.remove_duplicates(str)
    str.chars.uniq.join
  end
end

describe StringHelper do
  before do
    @helper = StringHelper
  end

  describe '.palindrome?' do
    it '检测回文串返回 true' do
      assert @helper.palindrome?('racecar')
    end

    it '检测回文串（忽略大小写）' do
      assert @helper.palindrome?('RaceCar')
    end

    it '检测回文串（忽略空格）' do
      assert @helper.palindrome?('a man a plan a canal panama')
    end

    it '非回文串返回 false' do
      refute @helper.palindrome?('hello')
    end

    it 'nil 返回 false' do
      refute @helper.palindrome?(nil)
    end

    it '空字符串返回 false' do
      refute @helper.palindrome?('')
    end
  end

  describe '.word_count' do
    it '正确统计单词数' do
      assert_equal 5, @helper.word_count('Ruby is a great language')
    end

    it '多个空格视为单个分隔符' do
      assert_equal 3, @helper.word_count('hello    world    ruby')
    end

    it '空字符串返回零' do
      assert_equal 0, @helper.word_count('')
    end

    it '仅空格返回零' do
      assert_equal 0, @helper.word_count('   ')
    end
  end

  describe '.capitalize_words' do
    it '每个单词首字母大写' do
      assert_equal 'Hello World Ruby', @helper.capitalize_words('hello world ruby')
    end

    it 'nil 返回空字符串' do
      assert_equal '', @helper.capitalize_words(nil)
    end
  end
end