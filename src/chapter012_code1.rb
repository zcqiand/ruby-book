# 最简单的正则：匹配字符串中是否包含 "Ruby"
/Ruby/ =~ "Hello, Ruby!"      # 返回匹配位置：7
/Ruby/ =~ "Hello, Python!"    # 返回 nil（匹配失败）

# %r{} 语法，pattern里有反斜杠时更清晰
%r{\d{4}-\d{2}-\d{2}} =~ "2024-01-15"   # 匹配日期格式