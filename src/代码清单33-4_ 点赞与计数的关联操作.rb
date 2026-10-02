user.liked_posts << post  # 点赞
user.liked_posts.count    # 该用户点赞总数
post.likers.count         # 该帖子点赞数