# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :user
  # 多态关联：likeable 可以是 Post、Comment 或其他任何模型
  belongs_to :likeable, polymorphic: true
  
  # 唯一性校验：同一用户对同一对象只能有一条点赞记录
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
  
  # 校验回调：确保不能重复点赞
  validate :no_duplicate_like, on: :create
  
  private
  
  def no_duplicate_like
    if Like.exists?(user_id: user_id, likeable_type: likeable_type, likeable_id: likeable_id)
      errors.add(:base, '你已经点过赞了')
    end
  end
end