# 双 token 刷新逻辑示例
class Api::TokensController < Api::ApplicationController
  skip_before_action :authenticate_token, only: [:refresh]

  # POST /api/token/refresh
  # 使用 refresh_token 换取新的 access_token
  def refresh
    refresh_token = params[:refresh_token]

    begin
      decoded = JWT.decode!(
        refresh_token,
        Rails.application.credentials.secret_key_base,
        true,
        { algorithm: 'HS256' }
      )

      # 生成新的 access_token
      new_access_token = JWT.encode(
        {
          user_id: decoded[0]['user_id'],
          exp: Time.now.to_i + 3600,  # 1小时有效期
          iat: Time.now.to_i
        },
        Rails.application.credentials.secret_key_base,
        'HS256'
      )

      render json: { access_token: new_access_token }

    rescue JWT::DecodeError
      render json: { error: 'Invalid refresh token' }, status: :unauthorized
    end
  end
end