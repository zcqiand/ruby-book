# N+1 优化后的时间线查询
def timeline_posts(page: 1, per_page: 20)
  following_ids = active_follows.select(:followed_id)
  Post.where(user_id: following_ids)
      .includes(:user, :likes, :comments)  # 预加载，避免 N+1
      .order(created_at: :desc)
      .page(page)
      .per(per_page)
end