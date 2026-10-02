# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user   # 评论作者
  belongs_to :post, counter_cache: true  # counter_cache 在此声明
  
  # 自关联：父评论（顶级评论的 parent_id 为 nil）
  belongs_to :parent, class_name: 'Comment', optional: true, inverse_of: :replies
  
  # 嵌套回复列表
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id,
           dependent: :destroy, inverse_of: :parent
  
  # 多态点赞
  has_many :likes, as: :likeable, dependent: :destroy
  
  # 内容校验：评论不超过1000字符
  validates :content, presence: true, length: { maximum: 1000 }
  
  # 递归获取所有嵌套回复（返回扁平的评论数组）
  # 使用 flat_map 展开嵌套结构
  def all_replies
    replies.flat_map { |reply| [reply, reply.all_replies] }
  end
  
  # 判断是否为顶级评论
  def top_level?
    parent.nil?
  end
  
  # 计算评论层级深度（用于视图渲染缩进）
  def depth
    parent ? parent.depth + 1 : 0
  end
end