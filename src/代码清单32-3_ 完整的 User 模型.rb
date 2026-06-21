# app/models/user.rb
# 用户模型：使用 has_secure_password 实现 BCrypt 密码哈希与验证

class User < ApplicationRecord
  # 邮箱格式验证：允许子域名如 user@company.example.co.uk
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  # 密码长度验证：最短8字符，防止弱密码
  validates :password, length: { minimum: 8 }, on: :create

  # has_secure_password 提供：
  # - password= setter：将明文密码加密存入 password_digest
  # - authenticate(password)：验证密码并返回用户或 false
  has_secure_password

  # 将邮箱统一存为小写，查询时忽略大小写
  before_save { email.downcase! }
end