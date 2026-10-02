# 新增任务
# 1. 生成新ID（当前最大ID + 1，或初始为1）
# 2. 创建Task对象
# 3. 存入哈希表
# 4. ID追加到数组末尾（保持插入顺序）
# 返回新创建的任务对象
def add(description)
  # 使用||= 安全处理空数组情况：(@task_ids.max || 0) + 1
  next_id = (@task_ids.max || 0) + 1
  task = Task.new(next_id, description)
  @tasks[next_id] = task
  @task_ids << next_id
  task
end