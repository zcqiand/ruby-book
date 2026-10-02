result = "Hello, Ruby!".match(/Ruby (\w+)/)
result[0]        # => "Ruby!"        完整匹配
result[1]        # => "!"            第一个捕获组（实际这个例子捕获不到有意义的内容）
result.begin(0)  # => 7              匹配开始位置
result.end(0)    # => 12             匹配结束位置