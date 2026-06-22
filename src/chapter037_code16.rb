# RS256 示例：使用 RSA 密钥对

# 生成密钥对（只需执行一次）
# private_key = OpenSSL::PKey::RSA.new(2048)
# public_key = private_key.public_key

# 签发（用私钥）
token = JWT.encode(payload, private_key, 'RS256')

# 验证（用公钥）
decoded = JWT.decode(token, public_key, true, { algorithm: 'RS256' })