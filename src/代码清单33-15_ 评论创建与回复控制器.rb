# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  # POST /posts/:post_id/comments
  # 创建顶级评论
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @post, notice: '评论成功'
    else
      redirect_to @post, alert: '评论失败：' + @comment.errors.full_messages.join(', ')
    end
  end
  
  # GET /comments/:id/reply
  # 准备回复表单
  def reply
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @reply = @post.comments.build(parent_id: @comment.id)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end