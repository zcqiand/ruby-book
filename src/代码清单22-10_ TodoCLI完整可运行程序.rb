#!/usr/bin/env ruby
# Todo CLI - 命令行任务管理工具
# 用法: ruby todo.rb [add|list|done|delete] [参数]

require 'json'
require 'fileutils'

DATA_FILE = 'tasks.json'

# ===================== Task类 =====================
class Task
  attr_reader :id, :description
  attr_accessor :done

  def initialize(id, description)
    @id = id
    @description = description
    @done = false
  end

  def to_hash
    { id: @id, description: @description, done: @done }
  end

  def mark_done
    @done = true
  end

  def to_s
    status = @done ? "[x]" : "[ ]"
    "#{status} #{@id}: #{@description}"
  end

  def self.from_hash(hash)
    task = new(hash['id'], hash['description'])
    task.done = hash['done']
    task
  end
end

# ===================== TaskManager类 =====================
class TaskManager
  def initialize
    @tasks = {}
    @task_ids = []
  end

  def add(description)
    next_id = (@task_ids.max || 0) + 1
    task = Task.new(next_id, description)
    @tasks[next_id] = task
    @task_ids << next_id
    task
  end

  def list
    return puts "暂无任务" if @task_ids.empty?
    @task_ids.each { |id| puts @tasks[id].to_s }
  end

  def done(id)
    task = @tasks[id]
    raise ArgumentError, "任务 #{id} 不存在" unless task
    task.mark_done
    task
  end

  def delete(id)
    task = @tasks[id]
    raise ArgumentError, "任务 #{id} 不存在" unless task
    @tasks.delete(id)
    @task_ids.delete(id)
    task
  end

  def find(id)
    @tasks[id]
  end

  def count
    @tasks.size
  end

  def done_tasks
    @task_ids.filter_map { |id| @tasks[id] if @tasks[id].done }
  end

  def pending_tasks
    @task_ids.filter_map { |id| @tasks[id] unless @tasks[id].done }
  end

  def to_array
    @task_ids.map { |id| @tasks[id].to_hash }
  end

  def load_from_array(array)
    array.each do |hash|
      task = Task.from_hash(hash)
      @tasks[task.id] = task
      @task_ids << task.id
    end
    @task_ids.sort!
  end
end

# ===================== 辅助方法 =====================
def load_manager
  manager = TaskManager.new
  return manager unless File.exist?(DATA_FILE)

  begin
    data = JSON.parse(File.read(DATA_FILE))
    manager.load_from_array(data)
  rescue JSON::ParserError
    puts "警告: 数据文件损坏，将重新开始"
  end
  manager
end

def save_manager(manager)
  File.write(DATA_FILE, JSON.pretty_generate(manager.to_array))
end

def with_error_handling
  yield
rescue ArgumentError => e
  puts "错误: #{e.message}"
  exit 1
rescue => e
  puts "错误: 未知错误: #{e.class} - #{e.message}"
  exit 1
end

# ===================== 主程序 =====================
if __FILE__ == $0
  command = ARGV[0]
  argument = ARGV[1]

  case command
  when 'add'
    with_error_handling do
      unless argument && !argument.empty?
        puts "错误: 请提供任务描述"
        exit 1
      end
      manager = load_manager
      task = manager.add(argument)
      save_manager(manager)
      puts "已添加任务: #{task}"
    end

  when 'list'
    with_error_handling do
      manager = load_manager
      manager.list
      puts "\n统计: 共#{manager.count}个任务，#{manager.pending_tasks.size}待办"
    end

  when 'done'
    with_error_handling do
      id = argument.to_i
      manager = load_manager
      task = manager.done(id)
      save_manager(manager)
      puts "已完成: #{task}"
    end

  when 'delete'
    with_error_handling do
      id = argument.to_i
      manager = load_manager
      task = manager.delete(id)
      save_manager(manager)
      puts "已删除: #{task}"
    end

  else
    puts "错误: 未知命令: #{command}"
    puts "输入 'ruby todo.rb --help' 查看帮助"
    exit 1
  end
end