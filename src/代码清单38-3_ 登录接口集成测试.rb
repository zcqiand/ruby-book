# spec/requests/api/sessions_spec.rb
# 登录接口测试：验证认证凭据和 token 发放
# 依赖: rspec-rails, factory_bot_rails, JWT gem

require 'rails_helper'

RSpec.describe 'API Sessions', type: :request do
  let(:user) do
    User.create!(
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  describe 'POST /api/login' do
    context 'with valid credentials' do
      it 'returns a token' do
        post '/api/login', params: {
          email: 'test@example.com',
          password: 'password123'
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('token')
        expect(json_response['token']).to be_a(String)
      end

      it 'token contains correct user_id' do
        post '/api/login', params: {
          email: 'test@example.com',
          password: 'password123'
        }

        json_response = JSON.parse(response.body)
        token = json_response['token']

        decoded = JWT.decode(
          token,
          Rails.application.credentials.secret_key_base,
          true,
          { algorithm: 'HS256' }
        )

        expect(decoded[0]['user_id']).to eq(user.id)
      end

      it 'token has correct expiration' do
        post '/api/login', params: {
          email: 'test@example.com',
          password: 'password123'
        }

        json_response = JSON.parse(response.body)
        token = json_response['token']

        decoded = JWT.decode(
          token,
          Rails.application.credentials.secret_key_base,
          true,
          { algorithm: 'HS256' }
        )

        exp_time = decoded[0]['exp']
        expected_exp = Time.now.to_i + 7.days

        # 允许1分钟误差
        expect(exp_time).to be > (expected_exp - 60)
        expect(exp_time).to be < (expected_exp + 60)
      end
    end

    context 'with invalid email' do
      it 'returns 401' do
        post '/api/login', params: {
          email: 'wrong@example.com',
          password: 'password123'
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid password' do
      it 'returns 401 without revealing which field is wrong' do
        post '/api/login', params: {
          email: 'test@example.com',
          password: 'wrongpassword'
        }

        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid credentials')
      end
    end
  end
end