# app/controllers/sessions_controller.rb
# 会话控制器：处理用户登录、退出登录的 HTTP 请求
# 使用 Rails session 存储用户身份，遵循 RESTful logout 使用 DELETE 方法

class SessionsController < ApplicationController
  # 登录页：GET /login
  def new
    # 渲染登录表单视图
  end

  # 创建会话：POST /login，处理登录验证
  def create
    user = User.find_by(email: params[:email]&.downcase)

    # authenticate 方法由 has_secure_password 提供
    # 内部调用 BCrypt::Password.new(user.password_digest) == password
    if user&.authenticate(params[:password])
      # 登录成功：在 session 中存储 user_id，后续请求通过 session[:user_id] 识别用户
      session[:user_id] = user.id
      redirect_to root_path, notice: "欢迎回来，#{user.name}"
    else
      # 登录失败：保留表单让用户重试，不泄露具体失败原因（防用户枚举攻击）
      flash.now[:alert] = "邮箱或密码错误"
      render :new, status: :unprocessable_entity
    end
  end

  # 删除会话：DELETE /logout，处理退出登录
  def destroy
    # 清除 session 中的 user_id，实现退出
    session.delete(:user_id)
    redirect_to login_path, notice: "已退出登录"
  end
end