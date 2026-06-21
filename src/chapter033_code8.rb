# db/migrate/20240101000002_create_comments.rb
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      # 自关联实现嵌套评论：parent_id 指向同表的另一条记录
      t.references :parent, foreign_key: { to_table: :comments }, null: true
      t.text :content, null: false
      t.timestamps
    end
    # 经常查询某帖子的所有评论
    add_index :comments, :post_id
    # 经常查询某评论的所有回复
    add_index :comments, :parent_id
  end
end