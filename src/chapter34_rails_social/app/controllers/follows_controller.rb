# frozen_string_literal: true

# FollowsController 处理关注/取关操作
# RESTful 风格下，关注作为 Users 资源的成员动作
class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  # POST /users/:user_id/follow
  # 关注指定用户
  def create
    if current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_back_or_to @user, notice: '已关注' }
        format.json { render json: { success: true, message: '已关注' } }
      end
    else
      respond_to do |format|
        format.html { redirect_back_or_to @user, alert: '关注失败' }
        format.json { render json: { success: false, message: '关注失败' }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/follow
  # 取关指定用户
  def destroy
    if current_user.unfollow(@user)
      respond_to do |format|
        format.html { redirect_back_or_to @user, notice: '已取消关注' }
        format.json { render json: { success: true, message: '已取消关注' } }
      end
    else
      respond_to do |format|
        format.html { redirect_back_or_to @user, alert: '取消关注失败' }
        format.json { render json: { success: false, message: '取消关注失败' }, status: :unprocessable_entity }
      end
    end
  end

  private

  # 获取要操作的用户对象
  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to root_path, alert: '用户不存在' }
      format.json { render json: { message: '用户不存在' }, status: :not_found }
    end
  end
end
