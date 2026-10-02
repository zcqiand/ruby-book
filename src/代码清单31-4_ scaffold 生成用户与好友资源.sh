# 生成用户相关资源（包含 name、email、password_digest 字段）
rails generate scaffold User name:string email:string password_digest:string

# 生成的好友关系表（多对多关联）
rails generate scaffold Friendship user_id:integer friend_id:integer