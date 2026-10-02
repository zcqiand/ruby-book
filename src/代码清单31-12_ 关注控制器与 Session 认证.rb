# app/controllers/users_controller.rb
class UsersController < ApplicationController
  # 仅登录用户可访问（除非声明 skip_before_action）
  before_action :authenticate_user!, except: [:index, :show]

  def follow
    @user = User.find(params[:id])
    current_user.following_relationships.create(friend: @user)
    redirect_to @user, notice: '已关注'
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.following_relationships.find_by(friend: @user)&.destroy
    redirect_to @user, notice: '已取消关注'
  end

  private

  # devise 或自定义认证方案提供的当前用户方法
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end