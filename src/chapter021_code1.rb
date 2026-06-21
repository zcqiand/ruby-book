# -*- coding: utf-8 -*-
# 这一章的代码统一使用 UTF-8 编码，避免中文乱码

# 假设执行: ruby todo.rb add "买牛奶"
# ARGV 的值是一个数组: ["add", "买牛奶"]
command = ARGV[0]
argument = ARGV[1]

puts "命令: #{command}"
puts "参数: #{argument}"

# 运行 ruby todo.rb add "买牛奶" 的输出:
# 命令: add
# 参数: 买牛奶