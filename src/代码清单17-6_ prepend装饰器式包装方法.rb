# prepend 的核心价值：像装饰器一样包装原有方法
module Timestamper
  def save
    puts "[Timestamper] 开始记录时间戳..."
    super  # super 调用方法查找链中的下一个方法（这里是 Record 的 save）
    puts "[Timestamper] 保存于 #{Time.now}"
  end
end

class Record
  prepend Timestamper  # 关键：prepend 将 Timestamper 放在 Record 之前

  def save
    puts "[Record] 正在保存数据..."
  end
end

puts "=== prepend 方法查找链验证 ==="
record = Record.new
record.save

puts "\n方法查找链: #{Record.ancestors.inspect}"
# 顺序是：[Timestamper, Record, Object, Kernel, BasicObject]