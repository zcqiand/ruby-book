class PostsController < ApplicationController
  # index 和 show 公开访问，创建和销毁需要登录
  before_action :require_login, except: [:index, :show]

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to @post
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
end