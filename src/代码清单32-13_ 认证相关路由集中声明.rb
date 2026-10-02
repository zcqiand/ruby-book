# config/routes.rb
# 认证相关路由：使用 Rails 7.1+ 的路由语法
# resources 生成 RESTful 路由，only/in extra 限制可用动作

Rails.application.routes.draw do
  # 会话路由：登录页 GET /login、会话创建 POST /login、删除 DELETE /logout
  resource :session, only: [:new, :create, :destroy]

  # 用户注册路由
  resources :users, only: [:new, :create]

  # 受保护的仪表盘
  resource :dashboard, only: [:show]

  # 首页
  root "home#index"

  # 命名路由别名：使 redirect_to login_path 等调用更清晰
  get "/login", to: "sessions#new", as: :login
  get "/logout", to: "sessions#destroy", as: :logout
  get "/signup", to: "users#new", as: :signup
end