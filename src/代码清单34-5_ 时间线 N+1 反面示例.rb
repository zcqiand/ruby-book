# 第一次查询：获取我关注的所有用户
following_users = current_user.following

# 第二次到第N次：分别查询每个用户的帖子
@posts = following_users.map(&:posts).flatten.sort_by(&:created_at).reverse