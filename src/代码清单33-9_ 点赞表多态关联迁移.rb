# db/migrate/20240101000003_create_likes.rb
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      # polymorphic: true 生成 likeable_type 和 likeable_id 两列
      # likeable_type 存储模型名（如 "Post"、"Comment"）
      # likeable_id 存储对应记录的 ID
      t.references :likeable, polymorphic: true, null: false
      t.timestamps
    end
    # 唯一索引：同一用户对同一对象只能点赞一次
    t.index [:user_id, :likeable_type, :likeable_id], unique: true
  end
end