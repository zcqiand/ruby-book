#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

# 第23章：Todo CLI 数据持久化与完工
# 实现基于JSON文件的任务存储，在程序重启后自动恢复数据
# 使用 Ruby 3.3+ 标准库，无需额外依赖

require 'json'
require 'fileutils'

# =============================================================================
# 配置常量
# =============================================================================

# 数据文件存放目录：放在用户家目录的 .todo-cli 子目录下
# 跨平台兼容：Windows/macOS/Linux 都能正确处理路径分隔符
DATA_DIR = File.join(Dir.home, '.todo-cli')
DATA_FILE = File.join(DATA_DIR, 'todos.json')

# =============================================================================
# 核心数据模型
# =============================================================================

# Todo项的数据结构是一个哈希
# id: 唯一标识，递增分配
# content: 任务描述
# completed: 完成状态
# created_at: 创建时间（ISO 8601格式，便于JSON序列化）
#
# 为什么用哈希而非OpenStruct：因为哈希的序列化是Ruby内置的，性能最佳
Todo = Struct.new(:id, :content, :completed, :created_at) do
  # 将Struct实例转换为普通哈希，供JSON序列化使用
  def to_h
    { id: id, content: content, completed: completed, created_at: created_at }
  end

  # 从哈希反序列化回Struct
  def self.from_h(hash)
    Todo.new(hash['id'], hash['content'], hash['completed'], hash['created_at'])
  end

  # 友好显示格式
  def to_s
    status = completed ? '[x]' : '[ ]'
    "#{status} #{id}. #{content}"
  end
end

# =============================================================================
# 数据持久化层
# =============================================================================

module TodoStore
  # 从JSON文件加载任务列表
  # @return [Array<Todo>] 任务数组，文件不存在时返回空数组
  #
  # 为什么返回空数组而非nil：简化调用方逻辑，无需nil检查
  # 为什么不在这里创建目录：让load方法保持纯净，save方法负责初始化
  def self.load
    return [] unless File.exist?(DATA_FILE)

    begin
      content = File.read(DATA_FILE)
      # JSON.parse 需要 symbolize_names: true 才能用字符串键访问
      # 但为了简单，我们直接用字符串键然后转换
      data = JSON.parse(content)
      data.map { |item| Todo.from_h(item) }
    rescue JSON::ParserError => e
      # 文件内容损坏时，返回空数组并提示用户
      # 生产环境应记录日志而非puts
      warn "警告: 数据文件格式错误 (#{e.message})，将重新开始"
      []
    rescue Errno::EACCES => e
      warn "错误: 无法读取数据文件: #{e.message}"
      []
    end
  end

  # 将任务数组保存到JSON文件
  # @param todos [Array<Todo>] 任务数组
  # @return [Boolean] 保存是否成功
  #
  # 为什么要用 JSON.pretty_generate：人类可读的格式化，便于调试和版本控制diff
  # 为什么要创建目录：确保数据目录存在，避免首次运行失败
  def self.save(todos)
    # 确保数据目录存在
    # parent=true 表示如果父目录不存在也一并创建
    FileUtils.mkdir_p(DATA_DIR)

    begin
      # 转换为哈希数组后再序列化
      data = todos.map(&:to_h)
      # indent: 2 + align: 2 提供友好的缩进格式
      json_content = JSON.pretty_generate(data, indent: '  ', align: 2)
      File.write(DATA_FILE, json_content, encoding: 'utf-8')
      true
    rescue Errno::EACCES => e
      warn "错误: 无法写入数据文件: #{e.message}"
      false
    rescue Errno::ENOENT => e
      warn "错误: 数据目录不存在: #{e.message}"
      false
    end
  end

  # 生成下一个可用ID
  # @param todos [Array<Todo>] 当前任务列表
  # @return [Integer] 下一个ID
  #
  # 为什么用最大ID+1而非自增计数器：避免ID冲突，允许删除后复用
  def self.next_id(todos)
    return 1 if todos.empty?
    todos.map(&:id).max + 1
  end
end

# =============================================================================
# CLI命令处理器
# =============================================================================

module CLI
  # 列出所有任务
  # @param todos [Array<Todo>] 任务列表
  def self.list(todos)
    if todos.empty?
      puts '暂无任务。输入 "todo add <内容>" 添加新任务。'
      return
    end

    puts "共有 #{todos.size} 个任务："
    puts '-' * 40
    todos.each { |todo| puts todo }
    puts '-' * 40

    # 统计完成情况
    completed = todos.count(&:completed)
    puts "已完成: #{completed}/#{todos.size}"
  end

  # 添加新任务
  # @param todos [Array<Todo>] 任务列表
  # @param content [String] 任务内容
  # @return [Array<Todo>] 更新后的任务列表
  def self.add(todos, content)
    # 为什么要strip后再检查：去除首尾空白，避免用户误输入空格
    content = content.strip
    if content.empty?
      warn '错误: 任务内容不能为空'
      return todos
    end

    new_todo = Todo.new(
      TodoStore.next_id(todos),
      content,
      false,
      Time.now.utc.iso8601
    )

    updated_todos = todos + [new_todo]
    if TodoStore.save(updated_todos)
      puts "已添加: #{new_todo}"
    else
      warn '错误: 保存失败'
    end
    updated_todos
  end

  # 标记任务完成
  # @param todos [Array<Todo>] 任务列表
  # @param id [Integer] 任务ID
  # @return [Array<Todo>] 更新后的任务列表
  def self.complete(todos, id)
    target = todos.find { |t| t.id == id }
    unless target
      warn "错误: 找不到 ID 为 #{id} 的任务"
      return todos
    end

    if target.completed
      puts "任务已经完成了: #{target}"
      return todos
    end

    # 创建新的Todo实例（Struct是不可变的），更新完成状态
    updated_todos = todos.map do |t|
      if t.id == id
        Todo.new(t.id, t.content, true, t.created_at)
      else
        t
      end
    end

    if TodoStore.save(updated_todos)
      puts "已完成: #{target.content}"
    else
      warn '错误: 保存失败'
    end
    updated_todos
  end

  # 删除任务
  # @param todos [Array<Todo>] 任务列表
  # @param id [Integer] 任务ID
  # @return [Array<Todo>] 更新后的任务列表
  def self.delete(todos, id)
    target = todos.find { |t| t.id == id }
    unless target
      warn "错误: 找不到 ID 为 #{id} 的任务"
      return todos
    end

    updated_todos = todos.reject { |t| t.id == id }

    if TodoStore.save(updated_todos)
      puts "已删除: #{target.content}"
    else
      warn '错误: 保存失败'
    end
    updated_todos
  end

  # 显示帮助信息
  def self.help
    <<~HELP
      Todo CLI - 任务管理工具

      使用方法:
        todo list                    # 列出所有任务
        todo add <任务内容>           # 添加新任务（内容需要用引号包裹）
        todo complete <ID>           # 标记任务完成
        todo delete <ID>             # 删除任务
        todo help                    # 显示帮助

      示例:
        todo add "买牛奶"
        todo add "整理文件"
        todo list
        todo complete 1
        todo delete 2

      数据存储在: #{DATA_FILE}
    HELP
  end
end

# =============================================================================
# 程序入口
# =============================================================================

def main
  # 加载现有数据
  # 放在这里而非模块初始化时，确保每次运行都能获取最新状态
  todos = TodoStore.load

  # 解析命令行参数
  # 为什么用case而非if：便于扩展更多命令
  command = ARGV[0]&.downcase
  arg1 = ARGV[1]

  case command
  when 'list', 'ls', 'l'
    CLI.list(todos)

  when 'add', 'a', 'new', 'n'
    if arg1.nil? || arg1.strip.empty?
      warn '错误: 请提供任务内容'
      warn '用法: todo add <任务内容>'
      exit 1
    end
    CLI.add(todos, arg1)

  when 'complete', 'done', 'c', 'd'
    if arg1.nil?
      warn '错误: 请提供任务ID'
      warn '用法: todo complete <ID>'
      exit 1
    end
    id = arg1.to_i
    if id <= 0
      warn '错误: 任务ID必须是正整数'
      exit 1
    end
    CLI.complete(todos, id)

  when 'delete', 'del', 'rm', 'r'
    if arg1.nil?
      warn '错误: 请提供任务ID'
      warn '用法: todo delete <ID>'
      exit 1
    end
    id = arg1.to_i
    if id <= 0
      warn '错误: 任务ID必须是正整数'
      exit 1
    end
    CLI.delete(todos, id)

  when 'help', 'h', '-h', '--help'
    puts CLI.help

  else
    if command.nil?
      puts CLI.help
    else
      warn "未知命令: #{command}"
      warn '输入 "todo help" 查看帮助'
      exit 1
    end
  end
end

# 仅当作为主程序运行时执行
# 这样可以 require 该文件而不立即执行
if __FILE__ == $PROGRAM_NAME
  main
end