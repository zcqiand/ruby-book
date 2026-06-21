# config/boot.rb
# Bundler 环境引导
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require "bundler/setup"  # 加载 Gemfile 中声明的所有 gem
require "bootsnap/setup"  # 加速启动（如果安装了 bootsnap gem）
