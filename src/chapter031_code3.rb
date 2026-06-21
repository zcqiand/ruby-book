# 查找 id 为 1 的用户
user = User.find(1)

# 读取属性
puts user.name    # => "小明"
puts user.email   # => "xiaoming@example.com"

# 关联查询——这个用户的所有帖子
user.posts.each do |post|
  puts post.title
end