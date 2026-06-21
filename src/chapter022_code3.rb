# TaskManager类：任务管理的核心逻辑类
# 设计决策：使用Hash存储任务（O(1)查找）+ Array维护插入顺序
class TaskManager
  def initialize
    # 哈希表：id => Task对象，提供O(1)查找速度
    @tasks = {}
    # 数组：存储任务ID的插入顺序，用于保持任务显示顺序
    @task_ids = []
  end
end