# frozen_string_literal: true

# 场景：读取用户配置文件，若文件不存在则使用默认配置
# 为什么要用 rescue：文件操作是外部 I/O，失败概率高，必须假设可能不存在

require 'json'

class ConfigLoader
  CONFIG_DIR = File.join(Dir.home, '.config', 'ruby-app').freeze

  def initialize(config_name)
    @config_name = config_name
    @config_path = File.join(CONFIG_DIR, "#{config_name}.json")
  end

  def load
    content = File.read(@config_path)
    JSON.parse(content)
  rescue Errno::ENOENT, Errno::ENOTDIR => e
    # Errno::ENOENT = "Error NO ENTry"（文件不存在）
    warn "配置文件不存在，使用默认配置: #{e.message}"
    default_config
  rescue JSON::ParserError => e
    warn "配置文件格式错误，跳过加载: #{e.message}"
    default_config
  rescue StandardError => e
    warn "读取配置时发生未知错误: #{e.message}"
    default_config
  end

  private

  def default_config
    { theme: 'light', language: 'zh-CN', debug: false }
  end
end

loader = ConfigLoader.new('user-settings')
puts "=== 配置加载演示 ==="
config = loader.load
puts "最终配置: #{config}"