#!/usr/bin/env ruby
# frozen_string_literal: true

# 批处理场景：读取目录下所有 .txt 文件，统计行数
# 本演示用 Dir.mktmpdir 创建临时目录，避免污染环境

require 'tmpdir'
require 'fileutils'

# 创建临时测试环境
tmpdir = Dir.mktmpdir
puts "测试目录: #{tmpdir}"

# 生成测试文件
test_files = {
  'chapter1.txt' => "第一行\n第二行\n第三行",
  'chapter2.txt' => "仅一行",
  'chapter3.txt' => "第一行\n第二行\n第三行\n第四行\n第五行"
}

test_files.each do |filename, content|
  File.write(File.join(tmpdir, filename), content)
end

# ===== 批处理逻辑 =====
# Dir.glob 模式匹配文件，*.txt 仅匹配当前目录的 txt 文件（非递归）
# 统计每个文件的行数并汇总
total_lines = 0
file_count = 0

Dir.glob(File.join(tmpdir, '*.txt')).each do |filepath|
  filename = File.basename(filepath)
  lines = File.readlines(filepath).size  # readlines 返回行数组
  total_lines += lines
  file_count += 1
  puts "  #{filename}: #{lines} 行"
end

puts "共处理 #{file_count} 个文件，总计 #{total_lines} 行"

# ===== 错误处理思路 =====
# 实际批处理中需要考虑：
# - 文件不存在: File.exist? 检查
# - 权限不足: rescue Errno::EACCES
# - 磁盘空间满: rescue Errno::ENOSPC
# - 编码问题: 指定 encoding: 'utf-8'

# 清理临时目录
FileUtils.rm_rf(tmpdir)
puts "临时测试文件已清理"