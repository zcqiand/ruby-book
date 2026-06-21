# 标记任务为已完成
# 参数id：任务ID
# 找不到任务时抛出标准RuntimeError，符合Ruby错误处理惯例
def done(id)
  task = @tasks[id]
  unless task
    raise ArgumentError, "任务 #{id} 不存在"
  end

  task.done? ? task : task.mark_done
  task
end