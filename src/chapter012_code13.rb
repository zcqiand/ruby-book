# Ruby 正则表达式完全指南
# 章节: 第12章 — 正则表达式
# 项目: Ruby从入门到项目实践

# =============================================================================
# 场景一: VALIDATION (验证)
# =============================================================================

puts "=" * 60
puts "场景一: 邮箱验证"
puts "=" * 60

# 邮箱验证正则表达式分解:
# ^[a-zA-Z0-9._%+-]+  — 本地部分(用户名): 字母、数字、点、下划线等
# @                   — 字面符号@
# [a-zA-Z0-9.-]+      — 域名第一部分
# \.                  — 字面点号
# [a-zA-Z]{2,}$       — 顶级域名: 字母至少2个

email_regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

test_emails = [
  "user@example.com",           # 有效
  "test.user+tag@gmail.com",    # 有效(含加号和点)
  "name@sub.domain.org.cn",     # 有效(多级域名)
  "invalid",                    # 无效(缺@)
  "@nodomain.com",              # 无效(缺用户名)
  "a@b.c",                      # 无效(顶级域名太短)
  "very.long.email+tag@company-name.co.uk"  # 有效
]

test_emails.each do |email|
  result = !!(email =~ email_regex)
  status = result ? "有效" : "无效"
  puts "  #{status.ljust(6)} | #{email}"
end

# =============================================================================
# 场景二: REPLACEMENT (替换)
# =============================================================================

puts "\n" + "=" * 60
puts "场景二: HTML 标签替换"
puts "=" * 60

html_content = "这是<b>加粗文字</b>和普通文字的混合，"
html_content += "还有<i>斜体文字</i>以及<b>另一处加粗</b>。"

puts "原文HTML:"
puts "  #{html_content}"

# 替换加粗标签: (.+?) 是非贪婪匹配
bold_pattern = /<b>(.+?)<\/b>/
markdown_text = html_content.gsub(bold_pattern) { "**#{$1}**" }

puts "\n转换为Markdown:"
puts "  #{markdown_text}"

# =============================================================================
# 场景三: EXTRACTION (提取)
# =============================================================================

puts "\n" + "=" * 60
puts "场景三: 手机号提取"
puts "=" * 60

phone_text = <<~TEXT
  联系方式:
  张三: 13812345678
  李四: 13987654321
  王五: 18655554444
  赵六: 010-12345678 (固定电话，不是手机)
  孙七: 1381234567 (少一位)
  周八: 23812345678 (非13x开头)
  吴九: 15912345678
TEXT

puts "原文文本:"
puts phone_text

# 手机号正则: 以13x/14x/15x/17x/18x/19x开头，共11位
phone_regex = /1[3-9]\d{9}/
phone_numbers = phone_text.scan(phone_regex)

puts "提取到的手机号:"
phone_numbers.each_with_index { |num, i| puts "  #{i + 1}. #{num}" }

# =============================================================================
# 捕获组深入用法: 日期解析
# =============================================================================

puts "\n" + "=" * 60
puts "捕获组使用示例: 日期解析"
puts "=" * 60

date_texts = [
  "2024-01-15",
  "2023/12/31",
  "1999.06.20",
  "2024年1月1日"  # 中文格式，不匹配
]

date_pattern = /(\d{4})[-\/.](\d{1,2})[-\/.](\d{1,2})/

date_texts.each do |text|
  match = text.match(date_pattern)
  if match
    year, month, day = $1, $2, $3
    puts "  #{text.ljust(20)} => #{year}-#{month.rjust(2, '0')}-#{day.rjust(2, '0')}"
  else
    puts "  #{text.ljust(20)} => 格式不匹配"
  end
end

puts "\n使用 MatchData 对象:"
date_texts.each do |text|
  match = text.match(date_pattern)
  if match
    puts "  #{match[0]}: 年=#{match[1]} 月=#{match[2]} 日=#{match[3]}"
  end
end

# =============================================================================
# 综合练习: 日志分析
# =============================================================================

puts "\n" + "=" * 60
puts "综合练习: Web访问日志分析"
puts "=" * 60

log_entries = <<~LOG
  192.168.1.100 - - [10/Oct/2024:13:55:36 +0800] "GET /index.html HTTP/1.1" 200 2326
  10.0.0.1 - - [10/Oct/2024:13:56:12 +0800] "POST /api/login HTTP/1.1" 401 512
  192.168.1.100 - - [10/Oct/2024:13:56:45 +0800] "GET /dashboard HTTP/1.1" 200 10240
  172.16.0.50 - - [10/Oct/2024:13:57:30 +0800] "GET /static/img/logo.png HTTP/1.1" 200 4521
LOG

log_pattern = /(\d+\.\d+\.\d+\.\d+) - - \[([^\]]+)\] "(GET|POST|PUT|DELETE) (\/\S*) HTTP\/[\d\.]+" (\d{3})/

puts "解析结果:"
log_entries.scan(log_pattern) do |ip, timestamp, method, path, status|
  puts "  IP: #{ip.ljust(15)} | #{method.ljust(6)} #{path.ljust(20)} | #{status}"
end

puts "\n状态码统计:"
status_counts = log_entries.scan(/HTTP\/[\d\.]+" (\d{3})/).flatten.group_by(&:itself)
status_counts.each do |code, occurrences|
  puts "  #{code}: #{occurrences.size}次"
end

puts "\n" + "=" * 60
puts "代码演示结束"
puts "=" * 60