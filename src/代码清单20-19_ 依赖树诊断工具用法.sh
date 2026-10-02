# 使用 bundle exec gem dependency 查看依赖树
bundle exec gem dependency rails
# 输出示例：
#   Gem rails-7.1.3.2
#     actioncable (= 7.1.3.2)
#     actionmailbox (= 7.1.3.2)
#     actionmailer (= 7.1.3.2)
#     actionpack (= 7.1.3.2)
#     ...

# 使用 bundle outdated 查看可更新的 Gem
bundle outdated
# 输出示例：
#   Gem          Current  Latest  Requested  Groups
#   rails        7.1.3.2  7.2.0   ~> 7.1.0    default
#   puma         6.4.2    6.5.0   ~> 6.0      default
#   minitest     5.21.3   5.22.0  ~> 5.21     test

# 使用 bundle show 查看特定 Gem 的安装路径
bundle show rails
# 输出示例：
#   /path/to/project/vendor/bundle/ruby/3.3.0/gems/rails-7.1.3.2