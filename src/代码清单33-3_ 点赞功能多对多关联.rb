class User < ApplicationRecord
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
end

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end

class Post < ApplicationRecord
  has_many :likes
  has_many :likers, through: :likes, source: :user
end