# db/migrate/20240621000001_create_follows.rb
class CreateFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :follows do |t|
      # follower_id: 发起关注的一方（主动关系）
      # followed_id: 被关注的一方（被动关系）
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :followed, foreign_key: { to_table: :users }, null: false
      t.timestamps

      # 唯一索引防止重复关注
      t.index [:follower_id, :followed_id], unique: true
      # 反向查询优化：根据被关注者快速查找所有关注者
      t.index :followed_id
    end
  end
end