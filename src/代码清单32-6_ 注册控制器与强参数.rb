# app/controllers/users_controller.rb
# 用户注册控制器：处理新用户注册表单
# create 成功后自动登录，让用户无需二次登录即可使用系统

class UsersController < ApplicationController
  # 渲染注册表单：GET /signup
  def new
    @user = User.new
  end

  # 创建用户：POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      # 注册成功：立即将用户加入 session，实现"注册即登录"
      session[:user_id] = @user.id
      redirect_to root_path, notice: "注册成功，欢迎 #{@user.name}"
    else
      # 注册失败：保留用户输入数据，重新渲染注册表单
      render :new, status: :unprocessable_entity
    end
  end

  private

  # 强参数：只允许创建用户时提交的字段，防止批量赋值攻击
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end