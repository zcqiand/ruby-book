# app/models/user.rb
# has_secure_password 自动加密密码并提供 authenticate 方法
class User < ApplicationRecord
  has_secure_password

  # 用户关注的人（正向关系）
  has_many :following_relationships,
           class_name: 'Friendship',
           foreign_key: 'user_id',
           dependent: :destroy

  has_many :following, through: :following_relationships, source: :friend

  # 粉丝（反向关系，通过对称的中间表查询）
  has_many :follower_relationships,
           class_name: 'Friendship',
           foreign_key: 'friend_id',
           dependent: :destroy

  has_many :followers, through: :follower_relationships, source: :user
end