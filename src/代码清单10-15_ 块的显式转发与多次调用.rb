# 块转发：把接收到的块传给另一个方法
def wrapped_method(&block)
  puts "Before"
  block.call
  puts "After"
end

def call_twice(&block)
  block.call
  block.call
end

# 结合使用
def repeat_with_prefix(prefix, &block)
  puts prefix
  block.call
end

repeat_with_prefix("=== ") { puts "Content" }