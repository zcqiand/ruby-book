# jwt_basics.rb
# 演示 JWT 2.x API：生成、验证、提取payload
# 依赖: gem 'jwt' (~> 2.0)

require 'jwt'

# 密钥配置：生产环境应从环境变量或 Rails credentials 读取
# 原因：硬编码密钥会被提交到版本库，存在安全风险
secret_key = ENV.fetch('JWT_SECRET_KEY', 'dev_secret_key_change_in_production')

# ============================================================
# 1. 生成 JWT Token
# ============================================================

# payload 包含用户标识和过期时间
# 原因：exp 过期时间是不可选的，防止 token 永久有效带来的安全风险
payload = {
  user_id: 42,
  role: 'admin',
  iat: Time.now.to_i,  # issued at，token 签发时间
  exp: Time.now.to_i + 3600  # 1小时后过期，3600秒
}

# JWT.encode(payload, secret, algorithm)
# HS256 是 HMAC-SHA256 对称加密，适合自建 API
# 非对称加密(RS256)适用于跨服务验证场景
token = JWT.encode(payload, secret_key, 'HS256')

puts "生成的 Token:"
puts token
puts

# ============================================================
# 2. 验证 JWT Token
# ============================================================

# JWT.decode 返回格式: [payload_hash, header_hash]
# 原因：返回数组而非单一对象，便于访问完整信息
begin
  decoded_array = JWT.decode(
    token,           # 待验证的 token
    secret_key,      # 密钥
    true,            # 验证签名
    { algorithm: 'HS256' }  # 必须指定算法，防止算法切换攻击
  )

  decoded_payload = decoded_array[0]
  decoded_header = decoded_array[1]

  puts "验证成功!"
  puts "Header: #{decoded_header}"
  puts "Payload: #{decoded_payload}"
  puts "用户ID: #{decoded_payload['user_id']}"
  puts "角色: #{decoded_payload['role']}"
  puts "过期时间: #{Time.at(decoded_payload['exp'])}"
  puts

rescue JWT::ExpiredSignature
  puts "Token 已过期"
rescue JWT::InvalidIatError
  puts "Token 的 iat 时间戳无效"
rescue JWT::VerificationError
  puts "签名验证失败"
rescue JWT::DecodeError => e
  puts "解码失败: #{e.message}"
end

# ============================================================
# 3. 过期 Token 验证演示
# ============================================================

puts "=== 过期 Token 测试 ==="

# 创建一个已过期的 token（过期时间设为 -1 秒前）
expired_payload = {
  user_id: 99,
  exp: Time.now.to_i - 1  # 已经过期
}
expired_token = JWT.encode(expired_payload, secret_key, 'HS256')

begin
  JWT.decode(expired_token, secret_key, true, { algorithm: 'HS256' })
  puts "这个 token 不应该通过验证"
rescue JWT::ExpiredSignature
  puts "正确捕获: JWT::ExpiredSignature - Token 已过期"
end