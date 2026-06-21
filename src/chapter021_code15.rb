# ARGV接收参数（注意程序名在 $0，不在 ARGV）
command = ARGV[0]
args = ARGV[1..-1]

# OptionParser处理选项
require 'optparse'
OptionParser.new { |p| p.on("-v") { |v| $verbose = v } }.parse!

# 哈希分发命令
commands = { "add" => -> { |a| add_task(a[0]) } }
commands[command]&.call(args)