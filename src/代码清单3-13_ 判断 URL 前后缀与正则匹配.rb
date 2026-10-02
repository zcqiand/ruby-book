url = "https://ruby-lang.org"
puts url.include?("ruby")
puts url.start_with?("https")
puts url.end_with?(".org")
puts url =~ /ruby/i
# 预期输出：
# true（include? 大小写敏感，"ruby" 在 URL 中存在）
# true
# true
# 12（正则 /ruby/i 中 i 表示忽略大小写）