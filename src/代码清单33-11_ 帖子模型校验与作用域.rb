# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user  # 每条帖子属于一个用户
  
  # 评论列表，counter_cache 在 Comment.belongs_to 中声明
  has_many :comments, dependent: :destroy
  
  # 多态点赞关联，Rails 自动处理 likeable_type = "Post"
  has_many :likes, as: :likeable, dependent: :destroy
  
  # 内容校验：标题必填且不超过255字符，正文必填
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  
  # scope：按时间倒序获取活跃帖子
  scope :recent, -> { order(created_at: :desc) }
end