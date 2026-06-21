# 创建 Rails API 应用命令

# 1. 创建新的 API-only Rails 应用
# --api 参数让 Rails 使用 API 专用模式，不加载视图、中间件等网页组件
rails new ecommerce_api --api

# 2. 进入项目目录
cd ecommerce_api

# 3. 创建数据库（PostgreSQL）
rails db:create

# 4. 运行迁移
rails db:migrate

# 5. 添加种子数据
rails db:seed

# 6. 启动服务器
rails server
# 或简写
rails s

# 访问 http://localhost:3000/api/v1/products 测试 API
