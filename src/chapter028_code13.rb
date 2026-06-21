# Gemfile — 项目依赖管理
# 为什么用 Gemfile：确保团队成员和部署环境使用相同版本的依赖
# 这是 Bundler 的标准做法，避免「在我机器上能运行」的依赖地狱

source 'https://rubygems.org'

# Sinatra Web 框架
gem 'sinatra'

# 激活 JSON 支持（Sinatra 内置，需要显式声明）
gem 'json'

# WEBrick 是 Ruby 标准库中的 HTTP 服务器，无需单独安装
# 其他可选服务器：puma（高并发）、unicorn（多进程）