def make_logger(level)
  # level 变量被块捕获
  lambda { |message| puts "[#{level}] #{message}" }
end

error_logger = make_logger("ERROR")
warn_logger = make_logger("WARN")

error_logger.call("数据库连接失败")  # => [ERROR] 数据库连接失败
warn_logger.call("配置文件缺失")    # => [WARN] 配置文件缺失