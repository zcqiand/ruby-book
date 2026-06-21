# frozen_string_literal: true

# 创建关注关联表
# 关注关系是用户之间的多对多关联，使用独立的 follows 表来实现
# 这样可以高效查询"我关注的人"和"关注我的人"
class CreateFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :follows do |t|
      # follower_id: 发起关注的一方（主动关系）
      # followed_id: 被关注的一方（被动关系）
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :followed, foreign_key: { to_table: :users }, null: false

      # 关注时间戳，用于时间线排序
      t.timestamps

      # 唯一索引防止重复关注
      # 数据库层面强制保证：同一用户不能多次关注同一个用户
      t.index [:follower_id, :followed_id], unique: true

      # 反向查询优化：根据被关注者快速查找所有关注者
      t.index :followed_id
    end

    # 添加备注说明外键约束的含义
    # follower 和 followed 必须指向不同的用户（应用层验证）
    # 外键约束确保引用完整性
  end
end
