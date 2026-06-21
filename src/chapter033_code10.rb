# app/models/user.rb
class User < ApplicationRecord
  # 用户拥有的帖子，删除用户时自动删除所有帖子
  has_many :posts, dependent: :destroy
  
  # 用户发表的评论，删除用户时自动删除所有评论
  has_many :comments, dependent: :destroy
  
  # 用户给出的所有点赞
  has_many :likes, dependent: :destroy
  
  # 嵌套关联：用户的所有嵌套回复（排除顶级评论）
  # 这是一个嵌套 has_many，用于统计用户参与度
  has_many :comment_replies, -> { where.not(parent_id: nil) },
           class_name: 'Comment', foreign_key: :user_id
end