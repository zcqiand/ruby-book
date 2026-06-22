# db/migrate/20240621000001_create_users.rb
# 用户表迁移：存储注册用户的基本认证信息
# 使用 BCrypt password_digest 而非明文存储密码，这是安全最佳实践

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      # password_digest 由 has_secure_password 自动验证 BCrypt 哈希
      t.string :password_digest, null: false
      t.string :name
      t.timestamps
    end
  end
end