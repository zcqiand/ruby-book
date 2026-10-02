# app/controllers/application_controller.rb
# 应用基础控制器：提供全栈用户身份识别与认证保护
# 所有继承此控制器的子控制器自动获得 current_user 和 require_login

class ApplicationController < ActionController::Base
  # 当前用户缓存：避免每次请求重复查询数据库
  # ||= 保证同一请求内只执行一次数据库查询
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # 让 current_user 在视图模板中可用
  helper_method :current_user

  # 登录判定：current_user 存在返回 true，用于视图条件渲染
  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

  # 认证保护过滤器：未登录用户重定向到登录页
  # 在需要保护的控制器中调用：before_action :require_login
  def require_login
    unless logged_in?
      # 存储原始请求路径，登录后可跳转回来源页面
      session[:forwarding_url] = request.original_url if request.get?
      redirect_to login_path, alert: "请先登录"
    end
  end
end