# app/controllers/api/sessions_controller.rb
# 用户登录接口：验证凭据并发放 JWT
# 设计决策：skip_before_action 确保登录接口无需认证即可访问

class Api::SessionsController < Api::ApplicationController
  # 登录接口不需要 token，skip_before_action 必须在 before_action 之后声明
  # 否则 before_action 仍会先执行
  skip_before_action :authenticate_token, only: [:create]

  # POST /api/login
  # 请求体: { "email": "user@example.com", "password": "password123" }
  def create
    # 1. 根据邮箱查找用户
    # find_by 而不是 find，原因是 find 在不存在时抛出异常，find_by 返回 nil
    user = User.find_by(email: params[:email])

    # 2. 验证密码
    # 使用 &.authenticate 因为 user 可能是 nil
    # authenticate 方法由 has_secure_password 提供，参数是明文密码
    if user&.authenticate(params[:password])
      # 3. 生成 JWT token
      # 设计决策：过期时间设为 7 天，平衡安全性与用户体验
      # 短期 token 更安全但需要频繁重新登录，长期 token 便利但风险增加
      token = JWT.encode(
        {
          user_id: user.id,
          exp: Time.now.to_i + 7.days,  # 7 天过期
          iat: Time.now.to_i             # 签发时间，用于计算 token 年龄
        },
        Rails.application.credentials.secret_key_base,
        'HS256'
      )

      # 4. 返回 token（不在响应中包含用户敏感信息）
      render json: { token: token }

    else
      # 5. 认证失败：返回通用错误信息
      # 原因：不区分"用户不存在"和"密码错误"，防止用户枚举攻击
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # DELETE /api/logout
  # 设计决策：JWT 是无状态的，logout 只能由客户端删除 token
  # 若需服务端注销，应使用 token 黑名单或 Redis 存储有效 token
  def destroy
    head :no_content
  end
end