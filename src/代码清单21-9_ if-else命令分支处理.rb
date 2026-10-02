command = ARGV[0]

if command == "add"
  # 添加任务逻辑
  task_text = ARGV[1]
  puts "添加任务: #{task_text}"
elsif command == "list"
  # 列出任务逻辑
  puts "列出所有任务"
elsif command == "done"
  # 完成任务逻辑
  task_id = ARGV[1].to_i
  puts "完成任务 ##{task_id}"
else
  puts "未知命令: #{command}"
end