# config/routes.rb
Rails.application.routes.draw do
  # 用户认证路由（假设使用 Devise）
  devise_for :users
  
  # 资源路由：posts 下的嵌套评论
  resources :posts do
    resources :comments, only: [:create]
  end
  
  # 评论的回复路由
  resources :comments, only: [] do
    member do
      get :reply  # 回复表单
    end
  end
  
  # 点赞路由
  post 'likes/toggle', to: 'likes#toggle', as: :likes_toggle
  
  # 首页
  root 'posts#index'
end