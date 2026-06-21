# 列出所有任务
# 按插入顺序遍历，保持用户创建任务的顺序
def list
  if @task_ids.empty?
    puts "暂无任务，输入 'ruby todo.rb add <任务描述>' 添加第一个任务"
    return
  end

  # 遍历@task_ids数组，按插入顺序获取任务
  @task_ids.each do |id|
    task = @tasks[id]
    puts task.to_s
  end
end