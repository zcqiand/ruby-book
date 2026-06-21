# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]  # 假设使用 Devise
  
  # GET /posts
  # 帖子列表页，预加载用户和评论数据避免 N+1 问题
  def index
    @posts = Post.includes(:user, :comments).recent
  end
  
  # GET /posts/:id
  # 帖子详情页，为新评论预留构建对象
  def show
    @comment = @post.comments.build  # 表单需要空对象
  end
  
  # GET /posts/new
  def new
    @post = current_user.posts.build
  end
  
  # POST /posts
  def create
    # current_user.posts.build 利用已登录用户自动填充 user_id
    @post = current_user.posts.build(post_params)
    
    if @post.save
      # Rails 自动处理重定向并显示 notice
      redirect_to @post, notice: '帖子发布成功'
    else
      # 校验失败时重新渲染表单
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /posts/:id
  def update
    # 只有作者才能编辑自己的帖子
    if @post.user == current_user && @post.update(post_params)
      redirect_to @post, notice: '帖子更新成功'
    else
      render :edit, status: :forbidden
    end
  end
  
  # DELETE /posts/:id
  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: '帖子已删除'
    else
      redirect_to @post, alert: '无权删除'
    end
  end
  
  private
  
  def post_params
    # 强参数：只允许传入 title 和 content，防止批量赋值攻击
    params.require(:post).permit(:title, :content)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
end