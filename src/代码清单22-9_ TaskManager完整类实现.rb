class TaskManager
  def initialize
    @tasks = {}
    @task_ids = []
  end

  # 新增任务
  def add(description)
    next_id = (@task_ids.max || 0) + 1
    task = Task.new(next_id, description)
    @tasks[next_id] = task
    @task_ids << next_id
    task
  end

  # 列出所有任务
  def list
    return puts "暂无任务" if @task_ids.empty?
    @task_ids.each { |id| puts @tasks[id].to_s }
  end

  # 标记任务完成
  def done(id)
    task = @tasks[id]
    raise ArgumentError, "任务 #{id} 不存在" unless task
    task.mark_done
    task
  end

  # 删除任务
  def delete(id)
    task = @tasks[id]
    raise ArgumentError, "任务 #{id} 不存在" unless task
    @tasks.delete(id)
    @task_ids.delete(id)
    task
  end

  # 根据ID查找任务
  def find(id)
    @tasks[id]
  end

  # 返回任务总数
  def count
    @tasks.size
  end

  # 列出已完成的任务
  def done_tasks
    @task_ids.filter_map { |id| @tasks[id] if @tasks[id].done }
  end

  # 列出待办任务
  def pending_tasks
    @task_ids.filter_map { |id| @tasks[id] unless @tasks[id].done }
  end

  # 将所有任务序列化为哈希数组（用于保存到文件）
  def to_array
    @task_ids.map { |id| @tasks[id].to_hash }
  end

  # 从哈希数组加载任务（用于从文件恢复）
  def load_from_array(array)
    array.each do |hash|
      task = Task.from_hash(hash)
      @tasks[task.id] = task
      @task_ids << task.id
    end
    @task_ids.sort!
  end
end