def maybe_process
  if block_given?
    puts "检测到块，开始处理..."
    yield
  else
    puts "没有块，照常执行默认逻辑"
  end
end

maybe_process { puts "自定义逻辑" }
# => 检测到块，开始处理...
# => 自定义逻辑

maybe_process
# => 没有块，照常执行默认逻辑