def execute_with_logging(&block)
  puts "Starting..."
  result = block.call
  puts "Finished with result: #{result}"
  result
end

execute_with_logging { sleep 0.1; 42 }
# 输出:
# Starting...
# Finished with result: 42