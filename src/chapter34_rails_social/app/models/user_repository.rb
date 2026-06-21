# frozen_string_literal: true

# 时间线查询示例模块
# 演示 N+1 问题的产生和解决
module TimelineQueryExamples
  # ===========================================
  # N+1 问题演示
  # ===========================================

  # 糟糕的实现：N+1 查询
  # 假设 current_user.following 返回 100 个用户
  # 这段代码会产生 1 + 100 = 101 次数据库查询
  def bad_timeline_query(current_user)
    # 查询 1：获取关注列表
    following = current_user.following

    # N 次查询：每个用户的帖子
    # 注意：如果有 100 个关注，每个用户的 posts 调用都会触发一次查询
    following.flat_map do |user|
      # 每次迭代都会执行: SELECT * FROM posts WHERE user_id = ?
      user.posts.order(created_at: :desc).limit(10)
    end
  end

  # 优化实现：预加载 (Preloading)
  # 只产生 3 次查询：
  # 1. SELECT * FROM users WHERE id IN (...), :following_ids
  # 2. SELECT * FROM posts WHERE user_id IN (...) ORDER BY created_at DESC
  # 3. SELECT * FROM users WHERE id IN (...)，如果需要预加载其他关联
  def optimized_timeline_query(current_user)
    # includes 触发预加载，将 following 的 posts 一次性查出
    current_user.following.includes(:posts).flat_map do |user|
      # 这里不再触发额外查询，posts 已在内存中
      user.posts.order(created_at: :desc).limit(10)
    end
  end

  # 更好的实现：直接在数据库层 join
  # 只需 1 次查询（在适当索引支持下）
  def best_timeline_query(current_user)
    Post.where(user_id: current_user.active_follows.select(:followed_id))
        .order(created_at: :desc)
        .limit(100)
  end

  # ===========================================
  # 预加载策略对比
  # ===========================================

  # 预加载 (preload)：强制两次查询，Rails 无法优化
  # 适用场景：需要同时访问关联对象和非关联对象
  def with_preload
    User.where(id: current_user.following_ids)
        .preload(:posts)
  end

  # 预加载 + 排序：通过 join 保持排序
  # 某些数据库（如 PostgreSQL）可以利用 index 提高性能
  def with_preload_and_order
    User.where(id: current_user.following_ids)
        .preload(:posts)
        .order("users.created_at DESC")
  end

  # 懒加载预读取 (eager_load)：使用 LEFT OUTER JOIN
  # 适用场景：总是需要关联数据
  def with_eager_load
    User.where(id: current_user.following_ids)
        .eager_load(:posts)
  end

  # 直接查询 (includes + references)：让 Rails 选择策略
  # 适用场景：不确定数据量，需要 Rails 自动优化
  def with_includes
    User.where(id: current_user.following_ids)
        .includes(:posts)
        .references(:posts) # 明确引用，强制 Rails 生成 JOIN
  end
end
