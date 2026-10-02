# 删除任务
# 1. 从哈希表中移除任务对象
# 2. 从ID数组中移除该ID
# 两处都要删除，确保数据一致性
def delete(id)
  task = @tasks[id]
  unless task
    raise ArgumentError, "任务 #{id} 不存在"
  end

  @tasks.delete(id)
  @task_ids.delete(id)  # Array#delete会移除所有匹配元素
  task
end