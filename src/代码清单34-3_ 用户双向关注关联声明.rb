# app/models/user.rb (关键部分)

# 主动关系：我关注的人
has_many :active_follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
has_many :following, through: :active_follows, source: :followed

# 被动关系：关注我的人
has_many :passive_follows, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
has_many :followers, through: :passive_follows, source: :follower