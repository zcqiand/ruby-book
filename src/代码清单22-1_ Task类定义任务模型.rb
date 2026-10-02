class Task
  def initialize(id, description)
    @id = id
    @description = description   # 任务描述
    @done = false               # 完成状态，默认为 false
  end

  attr_reader :id, :description
  attr_accessor :done

  def done?
    @done
  end

  def mark_done
    @done = true
  end

  def to_hash
    { id: @id, description: @description, done: @done }
  end

  def to_s
    status = @done ? "[x]" : "[ ]"
    "#{status} #{@id}: #{@description}"
  end

  def self.from_hash(hash)
    task = new(hash['id'], hash['description'])
    task.done = hash['done']
    task
  end
end