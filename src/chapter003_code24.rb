filename = "report.pdf"

# 检查文件扩展名
is_pdf = filename.end_with?(".pdf")

# 提取不含扩展名的文件名
base_name = filename.gsub(".pdf", "")

puts "是PDF？#{is_pdf}"
puts "文件名：#{base_name}"
# 输出：
# 是PDF？true
# 文件名：report