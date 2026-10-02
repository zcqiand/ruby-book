# 第1步：创建项目目录并进入
mkdir my_project && cd my_project

# 第2步：使用 bundle init 初始化 Gemfile（自动生成标准模板）
bundle init
# 输出：Writing new Gemfile to /path/to/my_project/Gemfile

# 第3步：查看生成的默认 Gemfile
cat Gemfile
# # frozen_string_literal: true
#
# source "https://rubygems.org"
#
# gem "rake"

# 第4步：编辑 Gemfile 添加自定义依赖
# 将上面的 Gemfile 示例内容写入 Gemfile

# 第5步：运行 bundle install 安装依赖
bundle install
# 执行结果示例：
# Resolving dependencies...
# Fetching gem metadata from https://rubygems.org/..........
# Resolving dependencies...
# Installing rails 7.1.3.2
# Installing activesupport 7.1.3.2
# Installing actionpack 7.1.3.2
# Installing actionview 7.1.3.2
# Installing builder 7.1.3.2
# Installing bigdecimal 1.7.0
# Installing concurrent-ruby 1.2.3
# Installing date 3.3.4
# Installing erubi 1.12.0
# Installing minitest 5.21.3
# Installing puma 6.4.2
# Installing spring 4.1.3
# ...
# Bundle complete! 15 gems to install.
# Gemfile defaults, ruby 3.3.0, and Bundled with 2.5.9

# 第6步：验证已安装的 Gem 列表
bundle list
# 输出示例：
#   actiontext (7.1.3.2)
#   actionpack (7.1.3.2)
#   activesupport (7.1.3.2)
#   bigdecimal (1.7.0)
#   capybara (3.40.0)
#   concurrent-ruby (1.2.3)
#   ...

# 第7步：查看生成的 Gemfile.lock（锁定精确版本）
cat Gemfile.lock
# 输出示例：
# GEM
#   remote: https://rubygems.org/
#   specs:
#     actiontext (7.1.3.2)
#       activerecord (>= 7.1.0, < 7.2.0)
#       activestorage (>= 7.1.0, < 7.2.0)
#       ...
#     rails (7.1.3.2)
#       actionmailbox (>= 7.1.0, < 7.2.0)
#       ...
#     puma (6.4.2)
#     ...
#
# PLATFORMS
#   ruby
#
# DEPENDENCIES
#   rails (~> 7.1.0)
#   puma (~> 6.0)
#   ...
#
# RUBY VERSION
#   ruby 3.3.0p0
#
# BUNDLED WITH
#    2.5.9

# 第8步：使用 bundle exec 执行 Ruby 代码（自动加载正确版本的 Gem）
bundle exec ruby -e "puts 'Hello from bundled environment'"
# 输出：Hello from bundled environment