# 创建一个帖子
post = Post.create(title: "我的第一篇帖子")

# 在这个帖子下创建评论——不需要手动写 INSERT
post.comments.create(body: "写得真好！")

# 获取这个帖子的所有评论
post.comments

# 反过来：通过评论找到它属于哪个帖子
comment = Comment.first
comment.post.title  # 自动 JOIN，无需手写 SQL