# app/models/follow.rb
class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # 验证：禁止用户关注自己
  validate :cannot_follow_self

  private
  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:base, '不能关注自己')
    end
  end
end