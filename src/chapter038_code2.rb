# spec/requests/api/products_spec.rb
# 商品 API 集成测试：验证认证流程和接口权限
# 依赖: rspec-rails, factory_bot_rails, JWT gem

require 'rails_helper'

RSpec.describe 'API Products', type: :request do
  # ============================================================
  # 测试数据准备
  # ============================================================

  # 使用 let 定义测试数据，延迟到首次访问时才创建
  # 原因：避免不必要的数据库写入（如果测试不涉及这些数据）
  let(:user) do
    # factory_bot 创建测试用户
    # create! 在创建失败时抛出异常，便于快速定位问题
    User.create!(
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  # 生成有效的 JWT token
  # 关键：token 必须在每次测试时重新生成，确保 exp 是当前时间
  let(:valid_token) do
    JWT.encode(
      {
        user_id: user.id,
        exp: Time.now.to_i + 3600,  # 1小时有效期
        iat: Time.now.to_i
      },
      Rails.application.credentials.secret_key_base,
      'HS256'
    )
  end

  # 过期 token，用于测试过期场景
  let(:expired_token) do
    JWT.encode(
      {
        user_id: user.id,
        exp: Time.now.to_i - 3600,  # 已过期1小时
        iat: Time.now.to_i - 7200
      },
      Rails.application.credentials.secret_key_base,
      'HS256'
    )
  end

  # ============================================================
  # GET /api/products 测试
  # ============================================================
  describe 'GET /api/products' do
    context 'with valid token' do
      it 'returns a successful response' do
        # 模拟已登录用户的请求
        # Authorization 头格式必须符合 Bearer scheme
        get '/api/products', headers: {
          'Authorization' => "Bearer #{valid_token}",
          'Accept' => 'application/json'
        }

        # 验证 HTTP 状态码
        expect(response).to have_http_status(:ok)

        # 验证响应体是 JSON
        expect(response.media_type).to eq('application/json')
      end

      it 'returns product list as array' do
        get '/api/products', headers: { 'Authorization' => "Bearer #{valid_token}" }

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('data')
        expect(json_response['data']).to be_an(Array)
      end
    end

    context 'without token' do
      it 'returns 401 Unauthorized' do
        get '/api/products'

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        get '/api/products'

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
        expect(json_response['error']).to include('Unauthorized').or include('Missing')
      end
    end

    context 'with expired token' do
      it 'returns 401 with expired message' do
        get '/api/products', headers: { 'Authorization' => "Bearer #{expired_token}" }

        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('expired').or include('Unauthorized')
      end
    end

    context 'with malformed token' do
      it 'returns 401 for invalid token format' do
        get '/api/products', headers: { 'Authorization' => 'Bearer not.a.valid.token' }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns 401 for token with wrong signature' do
        # 用错误的密钥生成一个"合法格式"的 token
        tampered_token = JWT.encode(
          { user_id: user.id, exp: Time.now.to_i + 3600 },
          'wrong_secret_key',
          'HS256'
        )

        get '/api/products', headers: { 'Authorization' => "Bearer #{tampered_token}" }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  # ============================================================
  # POST /api/products 测试（创建商品）
  # ============================================================
  describe 'POST /api/products' do
    let(:valid_product_params) do
      {
        name: 'Test Product',
        price: 99.99,
        stock: 50
      }
    end

    context 'with valid token and parameters' do
      it 'creates a new product' do
        post '/api/products',
             headers: { 'Authorization' => "Bearer #{valid_token}" },
             params: valid_product_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'without authentication' do
      it 'prevents product creation' do
        post '/api/products', params: valid_product_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end