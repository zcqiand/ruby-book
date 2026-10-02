# app/controllers/api/application_controller.rb
# API 控制器基类：集中处理 JWT 认证
# 原因：所有 API 控制器继承此类，避免在每个 controller 重复写认证逻辑

class Api::ApplicationController < ActionController::Base
  # 统一在层叠的最底层执行认证
  # before_action 会在每个 action 执行前运行，确保所有接口都需要认证
  before_action :authenticate_token

  # 将当前请求的用户 ID 提取为实例变量，供子类直接使用
  # 原因：避免每次从 token 解析后手动传递，提升开发体验
  attr_reader :current_user_id

  private

  # 认证核心逻辑
  # 设计决策：使用 request.headers['Authorization'] 格式，符合 RFC 6750 Bearer Token 规范
  def authenticate_token
    # 1. 从请求头提取 Bearer token
    # 格式: Authorization: Bearer <token>
    # split(' ').last 处理 Authorization: Bearer xxx 或直接是 token 两种情况
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    # 2. 无 token 情况：返回 401 而不是 403
    # 原因：401 表示"需要认证"，403 表示"已认证但无权限"
    unless token
      render json: { error: 'Missing authorization token' }, status: :unauthorized
      return
    end

    # 3. 解码并验证 token
    begin
      # JWT.decode! 在验证失败时会抛出异常，被 rescue 捕获
      # [0] 取 payload 部分（数组第一个元素是 payload，第二个是 header）
      decoded = JWT.decode!(
        token,
        Rails.application.credentials.secret_key_base,  # 使用 Rails 加密密钥
        true,                                            # 验证签名
        { algorithm: 'HS256' }
      )

      # 4. 提取用户 ID 并设置到实例变量
      # 原因：payload['user_id'] 是字符串（JSON key），需要转换为整数
      @current_user_id = decoded[0]['user_id'].to_i

    rescue JWT::ExpiredSignature
      # Token 过期：用户需重新登录
      render json: { error: 'Token has expired' }, status: :unauthorized

    rescue JWT::InvalidIatError
      # Token 的 iat 时间戳无效或在未来（可能涉及时钟同步问题）
      render json: { error: 'Invalid token timestamp' }, status: :unauthorized

    rescue JWT::VerificationError
      # 签名不匹配：token 被篡改或密钥错误
      render json: { error: 'Invalid token signature' }, status: :unauthorized

    rescue JWT::DecodeError
      # 其他解码错误：格式错误、密钥不匹配等
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end