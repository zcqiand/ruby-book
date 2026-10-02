module Observable
  # 当模块被 include 时，Ruby 会调用这个方法
  # 宿主类会被传入（这里用 base 表示）
  def self.included(base)
    puts "Observable module was included in #{base}"

    # 动态添加类方法到宿主类
    base.extend(ClassMethods)
  end

  # 这里是实例方法
  def notify_observers(event)
    puts "Notifying: #{event}"
  end

  # 嵌套模块，定义类方法
  module ClassMethods
    def add_observer(obj)
      puts "Adding observer: #{obj}"
    end
  end
end

class Process
  include Observable  # 触发 self.included 回调
end

# 测试
process = Process.new
process.notify_observers("task completed")
Process.add_observer(process)