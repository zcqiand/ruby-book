# 错误示范：不指定算法可能被算法切换攻击
JWT.decode(token, secret_key)

# 正确做法
JWT.decode(token, secret_key, true, { algorithm: 'HS256' })