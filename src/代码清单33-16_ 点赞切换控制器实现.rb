# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!
  
  # POST /likes/toggle?likeable_type=Post&likeable_id=1
  # 切换点赞状态：已点赞则取消，未点赞则添加
  def toggle
    # constantize 将字符串转为实际的模型类
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    
    # 查找当前用户的已有点赞
    @like = @likeable.likes.find_by(user: current_user)
    
    if @like
      # 已点赞：删除点赞记录
      @like.destroy
      render json: { 
        status: 'unliked', 
        count: @likeable.likes.count 
      }
    else
      # 未点赞：创建新点赞记录
      @likeable.likes.create(user: current_user)
      render json: { 
        status: 'liked', 
        count: @likeable.likes.count 
      }
    end
  end
end