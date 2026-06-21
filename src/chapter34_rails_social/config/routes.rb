# frozen_string_literal: true

# 路由配置
# 关注功能作为 Users 资源的成员动作
Rails.application.routes.draw do
  # 主页
  root 'home#index'

  # 用户资源及其关注相关路由
  resources :users, only: [:show, :index] do
    # 用户个人页面下显示关注/粉丝列表
    member do
      # POST /users/:user_id/follow - 关注用户
      post 'follow', to: 'follows#create'

      # DELETE /users/:user_id/follow - 取消关注
      delete 'follow', to: 'follows#destroy', as: 'unfollow'
    end

    # 嵌套资源：查看用户的关注列表和粉丝列表
    collection do
      get 'followers', to: 'users#followers'   # GET /users/followers
      get 'following', to: 'users#following'    # GET /users/following
    end
  end

  # 时间线路由
  # GET /timeline - 当前用户的时间线
  # GET /timeline?user_id=123 - 指定用户的时间线（可选）
  get '/timeline', to: 'timelines#show', as: :timeline

  # 帖子相关路由（Chapter 33 已实现，此处补充）
  resources :posts do
    resources :comments, only: [:create, :destroy]
    post 'like', to: 'likes#create'
    delete 'like', to: 'likes#destroy'
  end

  # 其他必要路由...
  # devise_for :users if using Devise
end
