task1 = Task.new(1, "完成报告")
task2 = Task.new(2, "回复邮件")

puts task1.to_s
# 输出: [ ] 1: 完成报告

task1.mark_done
puts task1.to_s
# 输出: [x] 1: 完成报告

puts task2.to_s
# 输出: [ ] 2: 回复邮件