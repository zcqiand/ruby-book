# app/models/user_repository.rb
module TimelineQueryExamples
  # 糟糕的实现：N+1 查询（1 + N 次）
  def bad_timeline_query(current_user)
    following = current_user.following
    following.flat_map do |user|
      user.posts.order(created_at: :desc).limit(10)  # 每次迭代触发查询
    end
  end

  # 优化：预加载（只需 2-3 次查询）
  def optimized_timeline_query(current_user)
    current_user.following.includes(:posts).flat_map do |user|
      user.posts.order(created_at: :desc).limit(10)  # 不再触发额外查询
    end
  end

  # 最佳：直接子查询（1 次查询）
  def best_timeline_query(current_user)
    Post.where(user_id: current_user.active_follows.select(:followed_id))
        .order(created_at: :desc)
        .limit(100)
  end
end