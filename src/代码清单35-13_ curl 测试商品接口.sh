# 获取商品列表
curl http://localhost:3000/api/v1/products

# 创建商品
curl -X POST http://localhost:3000/api/v1/products \
  -H "Content-Type: application/json" \
  -d '{"product":{"name":"Apple Watch","price":2999,"stock":50}}'