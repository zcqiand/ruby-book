# frozen_string_literal: true

# 时间线服务类
# 封装时间线相关的复杂业务逻辑
class TimelineService
  # 时间线聚合策略：
  # 1. 纯关注 (Following): 只显示关注用户的帖子
  # 2. 混合 (Hybrid): 关注用户的帖子 + 热门推荐
  # 3. 算法 (Algorithm): 综合考虑互动、时间、热度等因素
  class << self
    # 获取用户时间线
    # @param user [User] 当前用户
    # @param options [Hash] 配置选项
    # @option options [Symbol] :strategy 时间线策略 (:following, :hybrid, :algorithm)
    # @option options [Integer] :page 分页
    # @option options [Integer] :per_page 每页数量
    def for_user(user, strategy: :following, page: 1, per_page: 20)
      case strategy
      when :following
        following_timeline(user, page, per_page)
      when :hybrid
        hybrid_timeline(user, page, per_page)
      when :algorithm
        algorithm_timeline(user, page, per_page)
      else
        following_timeline(user, page, per_page)
      end
    end

    private

    # 纯关注时间线
    # 性能优化：使用子查询而非 JOIN，在大用户量下性能更好
    def following_timeline(user, page, per_page)
      # 子查询方式：Post.where(user_id: user.following_ids)
      # 比 JOIN 方式在 following 数量大时更快
      Post.where(user_id: user.following_ids)
          .includes(:user, :likes, :comments, :tags)
          .order(created_at: :desc)
          .page(page)
          .per(per_page)
    end

    # 混合时间线：80% 关注内容 + 20% 热门推荐
    def hybrid_timeline(user, page, per_page)
      # 限制关注内容比例，防止刷屏
      following_count = (per_page * 0.8).ceil

      # 获取关注用户的帖子
      following_posts = Post.where(user_id: user.following_ids)
                            .order(created_at: :desc)
                            .limit(following_count)

      # 补充热门帖子（排除已显示的）
      exclude_ids = following_posts.pluck(:id)
      hot_posts = Post.where.not(id: exclude_ids)
                      .order(likes_count: :desc, created_at: :desc)
                      .limit(per_page - following_count)

      # 合并并重新排序
      post_ids = (following_posts + hot_posts).map(&:id)
      Post.where(id: post_ids)
          .order("array_position(ARRAY#{post_ids}, id)")
          .page(1)
          .per(per_page)
    end

    # 算法时间线（简化版）
    # 实际生产环境需要机器学习模型
    def algorithm_timeline(user, page, per_page)
      # 简单评分：互动率 * 时间衰减
      # score = (likes_count * 1 + comments_count * 2) / (hours_ago + 1)
      #
      # 简化实现：结合用户兴趣标签和互动情况
      user_tags = user.interests.pluck(:name)

      Post.joins(:tags)
          .where(tags: { name: user_tags })
          .group(:id)
          .order("COUNT(likes.id) * 2 + COUNT(comments.id) * 3 DESC, posts.created_at DESC")
          .page(page)
          .per(per_page)
    end
  end
end
