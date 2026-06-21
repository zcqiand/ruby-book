#!/usr/bin/env ruby
# frozen_string_literal: true

# 本演示展示"读取CSV、解析成哈希、存为JSON"的最简洁写法
# 为避免依赖外部 CSV 文件，我们用 StringIO 生成虚拟 CSV 数据

require 'json'
require 'csv'

# ===== 准备测试数据：模拟一个 CSV 文件 =====
# csv_content 第一行是表头（书名,作者,定价,出版社），后续是数据行
# headers: true 让 CSV 将第一行作为列名处理，to_hash 返回的哈希键即为表头名
csv_content = <<~CSV
  书名,作者,定价,出版社
  Ruby实战手册,张三,89,人民邮电
  Rails权威指南,李四,128,电子工业
  Ruby元编程,王五,75,机械工业
CSV

# 用 StringIO 模拟文件，避免实际创建文件
csv_source = StringIO.new(csv_content)

# ===== 核心逻辑：三行代码 =====
# 第一行：CSV.read 读取并解析 CSV，headers: true 开启哈希映射
# 第二行：map { |row| row.to_hash } 将每行转成哈希（键为表头名）
# 第三行：JSON.pretty_generate 格式化输出到文件
data = CSV.read(csv_source, headers: true).map { |row| row.to_hash }
File.write('books.json', JSON.pretty_generate(data))

# ===== 验证结果 =====
puts "--- CSV 转 JSON 结果 ---"
puts File.read('books.json')

# ===== 扩展：处理真实文件时只需改一处 =====
# data = CSV.read('input.csv', headers: true).map { |row| row.to_hash }
# File.write('output.json', JSON.pretty_generate(data))

# 清理测试文件
File.delete('books.json') if File.exist?('books.json')