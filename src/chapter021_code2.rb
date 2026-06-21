#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'optparse'

# 使用哈希存储解析后的选项，而不是一堆独立变量
# 这样传递给其他方法时只需传一个哈希，保持接口简洁
options = {
  done: false,      # --done 显示已完成任务
  priority: nil,    # --priority=high|medium|low
  id: nil           # 用于 done/delete 命令的任务 ID
}

parser = OptionParser.new do |opts|
  opts.banner = "用法: todo <命令> [选项]"
  opts.separator "命令: add, list, done, delete"
  opts.separator ""

  opts.on("--done", "显示已完成的任务") do
    options[:done] = true
  end

  opts.on("--priority=VALUE", [:high, :medium, :low], "优先级 (high/medium/low)") do |p|
    options[:priority] = p
  end

  opts.on("-h", "--help", "显示帮助信息") do
    puts opts
    exit
  end
end

# 解析遇到的第一个非选项参数之前的选项
# 例如 `todo list --done` 会先解析 --done，再把 list 留在 ARGV
parser.parse!

command = ARGV[0]
task_text = ARGV[1]

puts "命令: #{command}"
puts "选项: #{options}"
puts "任务文本: #{task_text}"