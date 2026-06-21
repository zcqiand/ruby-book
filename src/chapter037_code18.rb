# config/routes.rb
# Rails 路由配置：JWT 认证 API 路由

Rails.application.routes.draw do
  # API 命名空间
  namespace :api do
    # 认证相关
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    post '/token/refresh', to: 'tokens#refresh'

    # 商品接口（需要认证）
    resources :products, only: [:index, :show, :create, :update, :destroy]

    # 订单接口（需要认证）
    resources :orders, only: [:index, :show, :create]
  end

  # 健康检查端点（无需认证）
  get '/health', to: proc { [200, { 'Content-Type' => 'application/json' }, ['{"status":"ok"}']] }
end