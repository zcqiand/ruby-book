# frozen_string_literal: true

# TimelinesController 处理用户时间线页面
# 时间线展示用户关注的所有人发布的最新内容
class TimelinesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]

  # GET /timeline
  # 用户个人时间线页面（已登录用户查看自己关注的内容）
  def show
    # current_user 由 devise 或自定义认证提供
    @posts = current_user.timeline_posts(
      page: params[:page] || 1,
      per_page: params[:per_page] || 20
    )

    # 渲染时间线视图，传递必要的数据
    # @user 用于显示"正在查看 XXX 的时间线"之类的信息
    @user = current_user

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @posts }
    end
  end

  private

  # 设置用户（用于公开时间线查看）
  # 某些社交平台允许查看他人的时间线
  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  rescue ActiveRecord::RecordNotFound
    redirect_to timeline_path, alert: '用户不存在'
  end
end
