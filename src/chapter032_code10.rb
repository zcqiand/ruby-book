# app/controllers/dashboard_controller.rb
# 受保护控制器示例：需要登录才能访问的仪表盘
# 演示 require_login 过滤器的实际使用场景

class DashboardController < ApplicationController
  # 所有动作都需要登录才能访问
  before_action :require_login

  # GET /dashboard
  def show
    # current_user 来自 ApplicationController，在视图中可直接使用
    @recent_activities = current_user.activities.order(created_at: :desc).limit(10)
  end
end