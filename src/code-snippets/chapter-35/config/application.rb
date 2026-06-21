# config/application.rb
# Rails 应用配置
require_relative "boot"

# API 模式下只加载必要的组件，减少内存占用
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

# 已加载的组件（不含 ActionDispatch、Coffee、Warden 等网页组件）：
# ActiveModel: 模型行为
# ActiveJob: 后台任务
# ActiveRecord: 数据库 ORM
# ActionController: 控制器
# ActionMailer: 邮件发送
# ActionView: 视图模板

Bundler.require(*Rails.groups)

module EcommerceApi
  class Application < Rails::Application
    # API 模式下默认使用 JSON 渲染
    config.api_only = true

    # 配置时区
    config.time_zone = 'Beijing'

    # Active Record 序列化 JSON 使用 oj 引擎（如果安装了）
    # config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time]
  end
end
