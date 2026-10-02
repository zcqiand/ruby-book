# 基本变量赋值
name = "Ruby"
author = "松本行弘"

# 字符串插值（使用双引号）
puts "Hello, #{name}!"
puts "#{name} 的创造者是 #{author}"

# 获取 Ruby 版本（内置常量）
puts "当前 Ruby 版本: #{RUBY_VERSION}"
puts "Ruby 引擎: #{RUBY_ENGINE}"

# 字符串方法演示
greeting = "hello world"
puts "原始字符串: #{greeting}"
puts "首字母大写: #{greeting.capitalize}"
puts "全部大写: #{greeting.upcase}"
puts "字符数量: #{greeting.length}"

# 多行字符串（使用 heredoc 语法）
multiline = <<~TEXT
  这是多行字符串的第一行
  这是第二行
  第三行
  #{name} 支持字符串插值!
TEXT
puts multiline

# 数组和迭代
languages = ["Ruby", "Python", "JavaScript"]
puts "支持的编程语言: #{languages.join(', ')}"