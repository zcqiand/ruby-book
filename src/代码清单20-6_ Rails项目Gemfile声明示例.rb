# 创建一个 Rails 项目常见的 Gemfile
# 路径：my_project/Gemfile

# 指定 Gem 源，RubyGems.org 是 Ruby 官方 Gem 仓库
source 'https://rubygems.org'

# 声明 Ruby 版本，确保团队开发环境一致
# Ruby 3.3+ 是本书的版本基线
ruby '3.3.0'

# 核心 Gem 依赖，使用 ~> 约束允许小幅升级
# ~> 7.1.0 表示 >= 7.1.0 且 < 7.2.0
gem 'rails', '~> 7.1.0'

# pry 是 Ruby 交互调试神器，~> 0.14 允许升级到 0.14.x
gem 'pry', '~> 0.14'

# >= 表示最低版本要求，允许任何更高版本
gem 'json', '>= 2.0'

# Puma 是 Rails 默认 Web 服务器，~> 6.0 约束主要版本
gem 'puma', '~> 6.0'

# development 组：仅开发环境安装，不进入生产部署
group :development do
  # listen 实现文件监听，热重载辅助
  gem 'listen', '~> 3.8'
  # Spring 加速 Rails 开发环境启动
  gem 'spring'
end

# test 组：仅测试环境安装，CI/CD 时会用到
group :test do
  # Minitest 是 Ruby 标准测试框架，5.x 是当前稳定版本
  gem 'minitest', '~> 5.21'
  # Capybara 模拟浏览器行为，用于集成测试
  gem 'capybara', '~> 3.40'
end