# 1. 运行迁移
rails db:migrate

# 2. 启动服务器
rails server -p 3001

# 3. 测试商品 CRUD
curl -X GET http://localhost:3001/api/v1/products
curl -X POST http://localhost:3001/api/v1/products \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT_TOKEN>" \
  -d '{"product":{"name":"Rails教程","price":99.00,"stock":100}}'

# 4. 测试下单
curl -X POST http://localhost:3001/api/v1/orders \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT_TOKEN>" \
  -d '{"order":{"shipping_address":"北京市朝阳区","items":[{"product_id":1,"quantity":2}]}}'