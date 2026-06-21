# 场景：管理1000个任务，根据ID查找某个任务

# 方法一：纯数组存储，查找效率O(n)
naive_tasks = []
1000.times { |i| naive_tasks << Task.new(i, "任务#{i}") }
found = naive_tasks.find { |t| t.id == 500 }  # O(n)时间复杂度

# 方法二：Hash+Array组合，查找效率O(1)
tasks_hash = {}
task_ids = []
1000.times do |i|
  task = Task.new(i, "任务#{i}")
  tasks_hash[i] = task   # O(1)写入
  task_ids << i          # 维护顺序
end
found = tasks_hash[500]  # O(1)时间复杂度！