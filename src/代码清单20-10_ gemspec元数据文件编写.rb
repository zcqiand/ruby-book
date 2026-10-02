# hello_gem.gemspec
# coding: utf-8
# frozen_string_literal: true

# 将 lib 目录加入加载路径，确保可以 require 版本号
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# 动态加载版本号，避免硬编码版本值导致不一致
require 'hello_gem/version'

# Gem::Specification 是 RubyGems 的核心类，声明 Gem 元数据
Gem::Specification.new do |spec|
  # Gem 名称，发布后不可更改
  spec.name          = "hello_gem"

  # 版本号，统一从 lib/hello_gem/version.rb 读取
  spec.version       = HelloGem::VERSION

  # 作者信息，RubyGems.org 展示用
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  # 简短描述（RubyGems.org 列表页展示）
  spec.summary       = "A simple gem to say hello"

  # 详细描述（Gem 主页展示）
  spec.description   = "This gem provides a simple way to greet users in multiple languages."

  # 项目主页 URL
  spec.homepage      = "https://github.com/yourname/hello_gem"

  # 开源许可证，MIT 是 Ruby 社区最常用的许可证
  spec.license       = "MIT"

  # 声明支持的 Ruby 最低版本，3.3.0 与版本基线一致
  spec.required_ruby_version = ">= 3.3.0"

  # 指定允许推送 Gem 的主机，nil 表示允许任何主机
  # 发布到 RubyGems.org 时需要设置此字段
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  # 添加开发依赖（仅 Gem 开发时需要，不影响使用者）
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.21"

  # 源码文件模式（自动包含 lib 下的 .rb 文件）
  spec.files = Dir["lib/**/*.rb", "README.md", "LICENSE.txt"]
end