class User < ApplicationRecord
  # has_secure_password 提供：
  # - password= setter：将明文密码加密存入 password_digest
  # - authenticate(password)：验证密码并返回用户或 false
  has_secure_password
end