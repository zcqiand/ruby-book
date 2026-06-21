# frozen_string_literal: true

# User 模型扩展：关注功能
# 用户之间通过 follows 表形成多对多关系
# 通过 active_follows（我关注的）和 passive_follows（关注我的）两个视角查询
class User < ApplicationRecord
  # ... 假设 Chapter 33 已有的关联保持不变
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # ===========================================
  # 关注功能：主动关系（我关注的人）
  # ===========================================
  # 通过 active_follows 中间表获取我关注的所有用户
  # source: :followed 指定通过 followed 关联获取用户对象
  has_many :active_follows,
           class_name: 'Follow',
           foreign_key: :follower_id,
           dependent: :destroy

  # 我关注的用户列表（following 是 following_users 的简称）
  has_many :following,
           through: :active_follows,
           source: :followed

  # ===========================================
  # 关注功能：被动关系（关注我的人）
  # ===========================================
  # 通过 passive_follows 中间表获取所有关注我的用户
  # source: :follower 指定通过 follower 关联获取用户对象
  has_many :passive_follows,
           class_name: 'Follow',
           foreign_key: :followed_id,
           dependent: :destroy

  # 关注我的用户列表（followers 是 follower_users 的简称）
  has_many :followers,
           through: :passive_follows,
           source: :follower

  # ===========================================
  # 关注操作方法
  # ===========================================

  # 关注指定用户
  # @param user [User] 要关注的用户对象
  # @return [Follow, false] 成功返回 Follow 对象，失败返回 false
  #
  # 设计考量：使用 Follow.create! 会抛出异常，使用 find_or_create_by
  # 可以处理并发关注的情况，避免重复记录导致数据库异常
  def follow(user)
    return false if user.nil? || user.id == id
    return false if following?(user)

    ActiveRecord::Base.transaction do
      active_follows.create!(followed_id: user.id)
    end
    true
  rescue ActiveRecord::RecordNotUnique
    # 并发情况下可能 race condition，忽略重复错误
    false
  end

  # 取关指定用户
  # @param user [User] 要取关的用户对象
  # @return [boolean] 是否成功取关
  def unfollow(user)
    return false if user.nil?

    active_follows.find_by(followed_id: user.id)&.destroy
    true
  end

  # 检查是否已关注指定用户
  # @param user [User] 要检查的用户对象
  # @return [boolean]
  def following?(user)
    return false if user.nil?

    # 使用 exists? 查询而非加载集合，避免加载不必要的数据
    active_follows.exists?(followed_id: user.id)
  end

  # ===========================================
  # 时间线查询
  # ===========================================

  # 获取关注用户的最新帖子（带 N+1 优化）
  # @param page [Integer] 分页页码
  # @param per_page [Integer] 每页数量
  # @return [ActiveRecord::Relation<Post>] 排序后的帖子集合
  #
  # N+1 问题说明：
  # - 原始写法：following.map(&:posts).flatten 会产生 1 + N 次查询
  # - 优化后：使用 includes 预加载 posts，只需 2 次查询
  # - includes 生成的 SQL 使用 LEFT OUTER JOIN，在 Ruby 层合并结果
  def timeline_posts(page: 1, per_page: 20)
    # 先获取我关注的用户 ID
    following_ids = active_follows.select(:followed_id)

    # 查询这些用户的所有帖子，按创建时间倒序
    # includes(:user) 预加载帖子作者信息，避免 N+1 问题
    # 如果不预加载，在视图中访问 @post.user 会触发额外查询
    Post.where(user_id: following_ids)
        .includes(:user, :likes, :comments)
        .order(created_at: :desc)
        .page(page)
        .per(per_page)
  end

  # 统计关注数和粉丝数（使用 counter_cache 更高效）
  # 这里提供方法以备不时之需，实际项目推荐在 follows 表加 counter_cache
  def following_count
    active_follows.count
  end

  def followers_count
    passive_follows.count
  end
end
