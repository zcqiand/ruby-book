# 查看当前安装的 Gem 版本
bundle exec gem list
# 输出示例：
#   actiontext (7.1.3.2)
#   actionpack (7.1.3.2)
#   activesupport (7.1.3.2)
#   rails (7.1.3.2)
#   ...

# 使用 bundle update 更新单个 Gem（保守策略）
bundle update rails
# Bundler 会尝试在不改变其他 Gem 版本的情况下更新 rails
# 输出：
#   Fetching gem metadata from https://rubygems.org/..........
#   Resolving dependencies...
#   Installing rails 7.2.0 (was 7.1.3.2)
#   Bundle updated!

# 使用 bundle update --conservative（更保守的更新）
# 仅更新 Gemfile 中明确指定的 Gem，不触发传递依赖的连锁更新
bundle update --conservative rails
# 这在大型团队中用于减少依赖变动范围，降低风险

# 完全重新解析依赖（当 Gemfile 发生重大变更时）
bundle update --ruby
# 根据当前 Gemfile 重新解析所有依赖，生成全新的 Gemfile.lock
# 适用于：添加/移除核心 Gem、Ruby 版本升级后
# 注意：可能导致大量 Gem 版本变化，需仔细 review Gemfile.lock 差异