# frozen_string_literal: true

# 场景：验证 Ruby "一切皆对象" 的设计哲学
# 为什么要验证：这是 Ruby 与其他语言最显著的区别

puts "=== 一切皆对象验证 ==="
puts "1.class = #{1.class}"
puts "'hello'.class = #{'hello'.class}"
puts "nil.class = #{nil.class}"
puts "true.class = #{true.class}"
puts "false.class = #{false.class}"
puts "[1, 2, 3].class = #{[1, 2, 3].class}"
puts "{a: 1}.class = #{{a: 1}.class}"
puts "(1..5).class = #{(1..5).class}"

# 每个对象都有 methods 方法，返回可用方法列表
puts "\n数字 42 的方法数量: #{42.methods.count}"
puts "字符串 'test' 的方法数量: #{"test".methods.count}"