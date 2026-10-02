# db/migrate/20240621000001_create_users.rb
# 使用 create_table 而非 raw SQL，Rails 自动处理主键和时间戳字段
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name      # 字符串类型，VARCHAR(255)
      t.string :email     # 用户唯一标识
      t.string :password_digest  # 使用 has_secure_password 时必需

      t.timestamps         # 自动添加 created_at 和 updated_at
    end
    # 为 email 添加唯一索引，避免查询时全表扫描
    add_index :users, :email, unique: true
  end
end