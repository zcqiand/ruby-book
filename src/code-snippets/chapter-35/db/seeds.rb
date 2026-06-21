# db/seeds.rb
# 数据库种子数据 - 为开发和测试提供初始数据
# 运行方式: rails db:seed

# 清空现有数据（按依赖顺序反向清空）
OrderItem.delete_all
Order.delete_all
Product.delete_all
User.delete_all

# 创建用户
users = User.create!([
  { name: '张三', email: 'zhangsan@example.com' },
  { name: '李四', email: 'lisi@example.com' },
  { name: '王五', email: 'wangwu@example.com' }
])
puts "Created #{users.count} users"

# 创建商品
products = Product.create!([
  {
    name: 'iPhone 15 Pro',
    description: 'Apple最新旗舰手机，A17 Pro芯片，钛金属设计',
    price: 7999.00,
    stock: 100
  },
  {
    name: 'MacBook Air M3',
    description: '轻薄高性能笔记本，搭载M3芯片，18小时续航',
    price: 9999.00,
    stock: 50
  },
  {
    name: 'AirPods Pro 2',
    description: '主动降噪无线耳机，USB-C充电盒',
    price: 1899.00,
    stock: 200
  },
  {
    name: 'iPad Air',
    description: '10.9英寸全面屏平板，M1芯片支持多任务',
    price: 4799.00,
    stock: 80
  },
  {
    name: 'Apple Watch Series 9',
    description: '智能手表，健康监测，S9芯片',
    price: 3199.00,
    stock: 120
  },
  {
    name: 'Magic Keyboard',
    description: '妙控键盘，带触控板',
    price: 899.00,
    stock: 0   # 无库存商品
  }
])
puts "Created #{products.count} products"

# 创建订单（演示不同状态）
order1 = Order.create!(
  user: users[0],
  shipping_address: '北京市朝阳区建国路88号',
  status: :completed
)

# 为订单1添加订单项
OrderItem.create!([
  { order: order1, product: products[0], quantity: 1, unit_price: products[0].price },
  { order: order1, product: products[2], quantity: 2, unit_price: products[2].price }
])

order2 = Order.create!(
  user: users[1],
  shipping_address: '上海市浦东新区世纪大道100号',
  status: :paid
)
OrderItem.create!(
  order: order2,
  product: products[1],
  quantity: 1,
  unit_price: products[1].price
)

order3 = Order.create!(
  user: users[2],
  shipping_address: '广州市天河区天河路383号',
  status: :pending
)
OrderItem.create!([
  { order: order3, product: products[3], quantity: 1, unit_price: products[3].price },
  { order: order3, product: products[4], quantity: 1, unit_price: products[4].price }
])

puts "Created #{Order.count} orders with #{OrderItem.count} order items"
puts "\n=== Seed Data Summary ==="
puts "Users: #{User.count}, Products: #{Product.count}, Orders: #{Order.count}, OrderItems: #{OrderItem.count}"
