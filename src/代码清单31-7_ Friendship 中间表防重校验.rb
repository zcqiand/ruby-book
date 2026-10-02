# app/models/friendship.rb
# 中间表模型，声明两侧的外键关系
class Friendship < ApplicationRecord
  belongs_to :user      # 关注者
  belongs_to :friend, class_name: 'User'  # 被关注者

  # 禁止重复关注（同一条记录不能出现两次）
  validates :user_id, uniqueness: { scope: :friend_id }
end