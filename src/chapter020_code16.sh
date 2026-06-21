# 修改 lib/hello_gem/version.rb 中的版本号
# VERSION = "0.2.0"
# 重新构建 Gem 包
gem build hello_gem.gemspec
# 重新发布
gem push hello_gem-0.2.0.gem
# 成功输出：
#   Pushing gem to https://rubygems.org...
#   Successfully registered gem: hello_gem (0.2.0)