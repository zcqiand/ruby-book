# 尝试安装依赖，观察是否有冲突
bundle install
# 正常输出：
#   Bundle complete! 15 gems to install.
#   Gemfile defaults, ruby 3.3.0, and Bundled with 2.5.9

# 冲突示例：假设 Gemfile 中声明了不兼容的版本
# gem 'rails', '~> 8.0'  # 但 gemspec 依赖 rails ~> 7.1
# bundle install
# 冲突输出：
#   Could not find gem 'rails (~> 8.0)' in the gemspecs.
#   Dependencies are not satisfied.