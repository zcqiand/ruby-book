#!/usr/bin/env ruby
# frozen_string_literal: true

# ===== 写入文件 =====
# File.write 一次性写入全部内容，返回写入的字节数
# 使用 'w' 模式会创建文件或覆盖已有内容
bytes_written = File.write('demo.txt', "第一行：Ruby 文件操作\n第二行：简单高效")
puts "写入 #{bytes_written} 字节到 demo.txt"

# ===== 读取文件全部内容 =====
# File.read 一次性读取整个文件到内存
# 适合小文件；大文件请用 each_line 分行处理
content = File.read('demo.txt')
puts "--- File.read 结果 ---"
puts content

# ===== 逐行读取 - each_line =====
# 逐行迭代是内存友好的方式，适合处理大文件
# File.open 配合代码块，每行读取时只占用当行的内存
# 每行末尾的换行符 \n 会保留在字符串中
puts "--- each_line 逐行读取 ---"
line_number = 0
File.open('demo.txt') do |file|
  file.each_line do |line|
    line_number += 1
    # chomp 去掉末尾换行符，使输出更整洁
    puts "行 #{line_number}: #{line.chomp}"
  end
end

# ===== 追加写入 =====
# 'a' 模式在文件末尾追加，不会覆盖已有内容
File.write('demo.txt', "\n第三行：追加内容", mode: 'a')
puts "--- 追加后的文件内容 ---"
puts File.read('demo.txt')

# 清理测试文件
File.delete('demo.txt') if File.exist?('demo.txt')