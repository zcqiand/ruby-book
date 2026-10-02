log = "INFO: 用户登录成功\nERROR: 数据库连接超时\nINFO: 处理请求\nERROR: 文件未找到"

log.scan(/ERROR: (.+)/).each do |message|
  puts "错误: #{message}"
end
# 输出:
# 错误: 数据库连接超时
# 错误: 文件未找到