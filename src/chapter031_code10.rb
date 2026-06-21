# config/routes.rb
Rails.application.routes.draw do
  # users 和 friendships 走标准 CRUD
  resources :users
  resources :friendships

  # 自定义关注/取关动作（POST 方法符合 REST 规范）
  resources :users do
    member do
      post :follow    # /users/:id/follow
      delete :unfollow # /users/:id/unfollow
    end

    collection do
      get :suggestions  # /users/suggestions 推荐用户
    end
  end

  # 根路径指向用户动态流
  root 'users#index'
end