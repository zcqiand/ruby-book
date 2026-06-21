# frozen_string_literal: true

# Follow 模型表示用户之间的关注关系
# 采用 follower/followed 命名而非 following，以准确描述数据所有关系
class Follow < ApplicationRecord
  # 关注者：发起关注动作的用户
  belongs_to :follower, class_name: 'User'

  # 被关注者：被关注的用户
  belongs_to :followed, class_name: 'User'

  # 验证：禁止用户关注自己
  # 这是业务规则层面的防护，数据库约束无法完全表达"不能等于自己"的逻辑
  validate :cannot_follow_self

  private

  # 自我关注没有实际意义，阻止这种操作
  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:base, '不能关注自己')
    end
  end
end
