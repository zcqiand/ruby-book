# app/services/timeline_service.rb
class TimelineService
  class << self
    def for_user(user, strategy: :following, page: 1, per_page: 20)
      case strategy
      when :following
        following_timeline(user, page, per_page)
      when :hybrid
        hybrid_timeline(user, page, per_page)  # 80% 关注 + 20% 热门
      when :algorithm
        algorithm_timeline(user, page, per_page)  # 兴趣标签 + 互动权重
      end
    end

    private

    def following_timeline(user, page, per_page)
      Post.where(user_id: user.following_ids)
          .includes(:user, :likes, :comments, :tags)
          .order(created_at: :desc)
          .page(page)
          .per(per_page)
    end

    def hybrid_timeline(user, page, per_page)
      following_count = (per_page * 0.8).ceil
      following_posts = Post.where(user_id: user.following_ids)
                            .order(created_at: :desc)
                            .limit(following_count)
      
      exclude_ids = following_posts.pluck(:id)
      hot_posts = Post.where.not(id: exclude_ids)
                      .order(likes_count: :desc, created_at: :desc)
                      .limit(per_page - following_count)

      post_ids = (following_posts + hot_posts).map(&:id)
      Post.where(id: post_ids).page(1).per(per_page)
    end
  end
end