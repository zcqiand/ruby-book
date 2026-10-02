#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# frozen_string_literal: true

# ============================================================
# Todo CLI — 命令行任务管理工具骨架
# Ruby 3.3+ / Bundler 2.x
# ============================================================

require 'optparse'

# ------------------------------------------------------------------
# 数据存储（下一章替换为持久化）
# ------------------------------------------------------------------
# 使用常量而非全局变量，符合 Ruby 风格指南建议
# TODO: 下一步替换为 JSON 文件持久化
TASKS = [
  { id: 1, text: '完成第21章代码', done: false, priority: :high },
  { id: 2, text: '编写测试用例', done: false, priority: :medium },
  { id: 3, text: '提交 PR', done: true, priority: :low }
].freeze

# ------------------------------------------------------------------
# 命令路由表
# ------------------------------------------------------------------
# 哈希分发模式：新增命令只需在此表添加一项
COMMANDS = {
  'add'    => method(:cmd_add),
  'list'   => method(:cmd_list),
  'done'   => method(:cmd_done),
  'delete' => method(:cmd_delete),
  'help'   => method(:cmd_help)
}.freeze

# ------------------------------------------------------------------
# 选项解析
# ------------------------------------------------------------------
# 返回解析后的选项哈希和剩余非选项参数
def parse_options!
  options = {
    done: false,
    priority: nil
  }

  OptionParser.new do |opts|
    opts.banner = "用法: todo <命令> [选项]"
    opts.separator "命令: #{COMMANDS.keys.join(', ')}"
    opts.separator "示例: todo add \"买牛奶\" --priority=high"
    opts.separator ""

    opts.on('--done', '显示已完成任务（仅 list 命令）') do
      options[:done] = true
    end

    opts.on('-pVALUE', '--priority=VALUE', [:high, :medium, :low],
            '设置优先级 (high/medium/low)') do |p|
      options[:priority] = p
    end

    opts.on('-h', '--help', '显示帮助') do
      puts opts
      exit
    end
  end.parse!

  # 返回哈希，允许使用 options.fetch(:done) 或 options[:done]
  options
end

# ------------------------------------------------------------------
# 命令处理器（桩实现，下一章填充逻辑）
# ------------------------------------------------------------------
def cmd_add(args)
  puts ">> [ADD] 添加任务: #{args[:text].inspect}"
  puts "    优先级: #{args[:priority] || 'normal'}"
  # TODO: 实现添加逻辑
end

def cmd_list(args)
  puts ">> [LIST] 任务列表"
  puts "    筛选: done=#{args[:done]}"
  puts "    优先级: #{args[:priority] || '全部'}"

  # 打印表头
  puts format("%-4s %-20s %-6s %-5s", "ID", "任务", "状态", "优先级")
  puts "-" * 40

  # 过滤并打印任务
  TASKS.each do |task|
    # 根据 --done 筛选
    next if args[:done] == false && task[:done]
    next if args[:done] == true && !task[:done]

    # 根据 --priority 筛选（统一用 to_sym 比较 Symbol）
    if args[:priority] && task[:priority] != args[:priority]
      next
    end

    status = task[:done] ? '[x]' : '[ ]'
    puts format("%-4d %-20s %-6s %-5s",
                task[:id],
                task[:text][0..19],
                status,
                task[:priority])
  end
  # TODO: 实现列表逻辑
end

def cmd_done(args)
  puts ">> [DONE] 标记任务 #{args[:id]} 为完成"
  # TODO: 实现完成标记逻辑
end

def cmd_delete(args)
  puts ">> [DELETE] 删除任务 #{args[:id]}"
  # TODO: 实现删除逻辑
end

def cmd_help(_args)
  puts "Todo CLI 帮助"
  puts "=" * 40
  puts "todo add \"任务内容\" --priority=high   添加新任务"
  puts "todo list [--done] [--priority=high]   列出任务"
  puts "todo done <id>                          标记任务完成"
  puts "todo delete <id>                        删除任务"
end

# ------------------------------------------------------------------
# 主路由分发
# ------------------------------------------------------------------
# 将解析逻辑与业务逻辑分离，便于单独测试 parse_options!
def run
  options = parse_options!

  command = ARGV[0] || 'help'
  handler = COMMANDS[command]

  unless handler
    puts "错误: 未知命令 '#{command}'"
    puts "运行 'todo help' 查看可用命令"
    exit 1
  end

  # 统一构建传递给命令处理器的参数哈希
  # 包含选项 + 位置参数，让处理器自行决定使用哪些字段
  cmd_args = {
    text: ARGV[1],           # add 命令的任务文本
    id: ARGV[1]&.to_i,       # done/delete 命令的任务 ID
    done: options[:done],
    priority: options[:priority]
  }

  handler.call(cmd_args)
end

# 脚本直接运行时不 require_relative，避免混淆
run if __FILE__ == $PROGRAM_NAME