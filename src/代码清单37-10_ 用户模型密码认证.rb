# app/models/user.rb
# 用户模型：使用 has_secure_password 提供密码认证
# 依赖: gem 'bcrypt'

class User < ApplicationRecord
  # has_secure_password 自动：
  # 1. 添加 password 和 password_confirmation 虚拟属性
  # 2. 密码加密存储（使用 bcrypt）
  # 3. 提供 authenticate 方法验证密码
  has_secure_password

  # 邮箱唯一性验证
  validates :email, presence: true, uniqueness: true

  # 示例：用户与商品的一对多关系
  has_many :products, dependent: :destroy
end