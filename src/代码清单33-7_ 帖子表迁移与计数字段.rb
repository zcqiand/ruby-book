# db/migrate/20240101000001_create_posts.rb
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      # 使用 references 自动创建 user_id 外键和索引
      t.references :user, null: false, foreign_key: true
      t.string :title, limit: 255  # 标题限制255字符
      t.text :content              # 正文使用 text 类型，支持长内容
      t.integer :comments_count, default: 0  # counter_cache 计数字段
      t.timestamps                # 自动管理 created_at 和 updated_at
    end
    # 经常按用户查询帖子，加索引优化
    add_index :posts, :user_id
  end
end