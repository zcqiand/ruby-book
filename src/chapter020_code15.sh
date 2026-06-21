# 在项目 Gemfile 中添加依赖
echo 'gem "hello_gem", "~> 0.1.0"' >> Gemfile
bundle install
# 成功输出：
#   Fetching gem metadata from https://rubygems.org/..........
#   Installing hello_gem 0.1.0
#   Bundle complete! 3 gems to install.