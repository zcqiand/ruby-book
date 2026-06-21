# 修改 lib/my_gem.rb 代码后
# 更新 gemspec 中的 version
gem build my_gem.gemspec
gem push my_gem-0.2.0.gem