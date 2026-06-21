#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# 命令与处理函数的映射表
# 使用 Method 对象而非字符串，让分发时直接调用，无需 eval
COMMANDS = {
  'add'    => method(:handle_add),
  'list'   => method(:handle_list),
  'done'   => method(:handle_done),
  'delete' => method(:handle_delete)
}

def handle_add(args)
  puts "添加任务: #{args[:text]} (优先级: #{args[:priority] || 'normal'})"
end

def handle_list(args)
  filter_done = args[:done] ? "已完成" : "未完成"
  puts "列出 #{filter_done} 任务"
end

def handle_done(args)
  puts "标记任务 #{args[:id]} 为完成"
end

def handle_delete(args)
  puts "删除任务 #{args[:id]}"
end

# 命令路由分发器
def dispatch(command, args)
  handler = COMMANDS[command]
  if handler
    handler.call(args)
  else
    puts "未知命令: #{command}"
    puts "可用命令: #{COMMANDS.keys.join(', ')}"
    exit 1
  end
end

# 模拟调用
dispatch('add',    { text: '买牛奶', priority: 'high' })
dispatch('list',   { done: true })
dispatch('done',   { id: 5 })
dispatch('delete', { id: 3 })
dispatch('invalid', {})