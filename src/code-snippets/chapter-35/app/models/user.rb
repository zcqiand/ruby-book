# app/models/user.rb
# 用户模型（简化版）- 用于展示订单关联
class User < ApplicationRecord
  has_many :orders, dependent: :destroy                # 用户的所有订单

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
