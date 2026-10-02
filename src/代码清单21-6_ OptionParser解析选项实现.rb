require 'optparse'

options = {}
OptionParser.new do |parser|
  parser.on("-n", "--number", "显示行号") do |v|
    options[:number] = v
  end
end.parse!

puts options[:number]  # 用户输入 -n 或 --number 时为 true