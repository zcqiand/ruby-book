command = ARGV[0]

case command
when "add"
  # 添加任务逻辑
when "list"
  # 列出任务逻辑
when "done"
  # 完成任务逻辑
when "delete"
  # 删除任务逻辑
else
  puts "未知命令"
end