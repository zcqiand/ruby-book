#!/usr/bin/env ruby
# frozen_string_literal: true

# ===== puts 与 print 的区别 =====
# puts 自动在末尾添加换行符，print 不会
puts "puts 输出第一行"
puts "puts 输出第二行"
print "print 输出第一行"
print " — 没有换行"
print "\n"  # 手动添加换行

# ===== gets 用户输入 =====
# gets 读取用户输入的一行（包含末尾换行）
# 注意：在实际程序中使用 gets 时需注意：
#   - 脚本参数可用 ARGV[0] 替代交互式输入
#   - 交互式输入时 gets 会阻塞等待用户回车
# 演示时我们用 StringIO 模拟输入，避免阻塞
require 'stringio'

# 模拟用户输入两行内容
fake_input = StringIO.new("Ruby\n3.3.0\n")
$stdin = fake_input

puts "请输入你的名字："
name = gets.chomp  # chomp 去掉换行符
puts "请输入 Ruby 版本："
version = gets.chomp

puts "--- 输入结果 ---"
puts "你好，#{name}！你使用的是 Ruby #{version}"

# 恢复标准输入
$stdin = STDIN