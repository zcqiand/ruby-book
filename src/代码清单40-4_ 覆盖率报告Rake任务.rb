# lib/tasks/coverage.rake
# 用于生成测试覆盖率报告的 Rake 任务
# 被 .github/workflows/ci.yml 中的 coverage step 调用
# 依赖 SimpleCov gem（Gemfile 中声明 simplecov gem）

# 仅在 test 环境启用覆盖率，避免影响生产环境性能
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  require 'simplecov-lcov'

  # SimpleCov 使用启动器（formatter）模式，多个 formatter 可同时输出不同格式
  # 先设置 HTML 报告formatter（用于本地查看）
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,      # 人类可读的 HTML 报告
    SimpleCov::Formatter::LcovFormatter,      # LCOV 格式（供 Codecov 解析）
  ])

  # LCOV formatter 配置：与 Codecov 集成时需要设置正确的 branch coverage
  SimpleCov::Formatter::LcovFormatter.config do |config|
    config.report_with_single_file = true
    config.output_directory = 'coverage'
    config.lcov_file_name = 'coverage.lcov'
  end

  # 项目根目录（GitHub Actions 中 checkout 到不同目录时需正确设置）
  SimpleCov.root(File.join(__dir__, '..', '..'))

  # 源码目录配置（与 application.rb 中的 app 目录对应）
  SimpleCov.add_src_directory('app')

  # 启动覆盖率收集（必须在被测代码加载之前执行）
  SimpleCov.start do
    # 过滤框架和第三方代码，只统计项目自身代码的覆盖率
    add_filter '/vendor/'
    add_filter '/spec/'
    add_filter '/test/'
    
    # 覆盖率的最小阈值（百分比），低于此值则 CI 失败
    # 初始项目覆盖率可以设低，逐步提升
    minimum_coverage 70
    
    # 分支覆盖率阈值（Ruby 3.1+ 支持）
    minimum_coverage_by_line 80
    minimum_branch_coverage 70
  end
end

# Rake 任务定义：运行测试并生成覆盖率报告
# 使用 rake coverage 调用，等价于先运行 test 再生成报告
desc '运行测试并生成覆盖率报告'
task coverage: :environment do
  # 如果在 CI 环境，SimpleCov 已通过上面的 require 'simplecov' 自动启动
  # 本地运行时直接调用 test 任务
  if ENV['CI'].blank?
    puts "\n==> 运行测试...\n"
    # Rake::Task['test'] 调用 test 任务，内部会触发 SimpleCov 结果生成
    Rake::Task['test'].invoke
  end

  # 输出覆盖率报告文件位置
  puts "\n==> 覆盖率报告已生成"
  puts "    HTML 报告: #{SimpleCov.coverage_path}/index.html"
  puts "    LCOV 报告: #{SimpleCov.coverage_path}/coverage.lcov"
end

# 任务依赖：coverage 依赖 test 任务确保测试先执行
# 这样可以确保 coverage 报告是基于最新测试结果
task default: [:coverage]