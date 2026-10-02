require 'securerandom'

uuid = SecureRandom.uuid  # 每次调用生成不同的UUID
puts uuid  # 打印类似 "550e8400-e29b-41d4-a716-446655440000"