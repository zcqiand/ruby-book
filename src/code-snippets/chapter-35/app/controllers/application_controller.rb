# app/controllers/application_controller.rb
# API 基类控制器 - 所有 API 控制器继承此类
class ApplicationController < ActionController::API
  # ActionController::API 是 Rails API 模式的基类
  # 比 ActionController::Base 更轻量，不包含网页视图相关功能

  # 统一错误处理
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_bad_request

  private

  def render_not_found(exception)
    render json: {
      success: false,
      error: exception.message || '资源不存在'
    }, status: :not_found
  end

  def render_bad_request(exception)
    render json: {
      success: false,
      error: exception.message || '请求参数错误'
    }, status: :bad_request
  end
end
