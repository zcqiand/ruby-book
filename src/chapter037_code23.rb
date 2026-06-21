# 推荐：明确指定算法
JWT.decode(token, key, true, { algorithm: 'HS256' })

# 不推荐：让库自动检测算法
JWT.decode(token, key, true)  # 危险！