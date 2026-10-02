# =============================================================================
# 第十章 代码示例：块(Block)、Proc 与 Lambda
# =============================================================================

puts "=== 示例 1：块的两种语法 ==="

# do/end 风格（适合多行逻辑）
[1, 2, 3].each do |x|
  puts "Value: #{x}"
end

# {} 风格（适合单行操作）
[1, 2, 3].each { |x| puts "Value: #{x}" }

puts "\n=== 示例 2：yield 用法 ==="

def twice
  yield(1)
  yield(2)
end

twice { |n| puts "Got: #{n}" }

puts "\n=== 示例 3：block_given? 可选块 ==="

def maybe_increment(x)
  if block_given?
    yield(x) + 1
  else
    x + 1
  end
end

puts maybe_increment(5)
puts maybe_increment(5) { |n| n * 2 }

puts "\n=== 示例 4：Proc 创建与调用 ==="

double = Proc.new { |x| x * 2 }
square = Proc.new { |x| x ** 2 }

p double.call(5)
p square.call(5)

triple = ->(x) { x * 3 }
p triple.call(5)

puts "\n=== 示例 5：Proc vs Lambda 参数检查 ==="

my_proc = Proc.new { |x, y| "x=#{x}, y=#{y}" }
p my_proc.call(1, 2, 3)

my_lambda = ->(x, y) { "x=#{x}, y=#{y}" }
begin
  my_lambda.call(1, 2, 3)
rescue ArgumentError => e
  puts "Lambda error: #{e.message}"
end

puts "\n=== 示例 6：Proc vs Lambda return 行为 ==="

def make_counter
  count = 0
  Proc.new { count += 1 }
end

counter = make_counter
p counter.call
p counter.call
p counter.call

def bad_example
  proc = Proc.new { return "early exit" }
  proc.call
  "this never executes"
end

p bad_example

def good_example
  lam = -> { return "from lambda" }
  lam.call
  "this executes"
end

p good_example

puts "\n=== 示例 7：闭包示例 ==="

def create_greeter(prefix)
  message = "Hello"
  ->(name) { "#{prefix}, #{message} #{name}!" }
end

morning_greeter = create_greeter("Good morning")
evening_greeter = create_greeter("Good evening")

p morning_greeter.call("Alice")
p evening_greeter.call("Bob")

puts "\n=== 示例 8：each 和 map 实战 ==="

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

squared_evens = numbers.select(&:even?).map { |n| n ** 2 }
p squared_evens

def custom_map(array)
  result = []
  array.each do |item|
    result << yield(item)
  end
  result
end

p custom_map([1, 2, 3]) { |n| n * 2 }
p custom_map(["hello", "world"]) { |s| s.upcase }

puts "\n=== 示例 9：&block 显式参数 ==="

def execute_with_logging(&block)
  puts "Starting..."
  result = block.call
  puts "Finished with result: #{result}"
  result
end

execute_with_logging { sleep 0.1; 42 }