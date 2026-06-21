# Rails Console API 测试示例
# 运行命令: rails console

# ===== 商品操作 =====

# 查看所有商品
Product.all

# 创建商品
Product.create!(
  name: 'ThinkPad X1 Carbon',
  description: '商务轻薄笔记本',
  price: 8999.00,
  stock: 30
)

# 查询有库存的商品
Product.available

# 查询低价商品
Product.cheap

# 更新商品
p = Product.find(1)
p.update!(stock: 99)

# 删除商品
p.destroy!

# ===== 订单操作 =====

# 查看所有订单
Order.all

# 查看订单及其订单项
order = Order.includes(:order_items, :products).find(1)
order.order_items
order.products

# 查看订单总金额
order.total_amount

# 订单状态转换
order.paid!           # 标记为已支付
order.shipped!        # 标记为已发货
order.completed!      # 标记为已完成

# 查看某用户的所有订单
user = User.first
user.orders

# ===== 关联创建 =====

# 创建订单同时添加订单项
user = User.first
product = Product.first

order = Order.create!(
  user: user,
  shipping_address: '北京市海淀区中关村大街1号'
)

order.order_items.create!(
  product: product,
  quantity: 2
)

# ===== 枚举查询 =====

Order.pending.count    # 待支付订单数
Order.paid.count       # 已支付订单数
Order.shipped.count    # 已发货订单数
Order.completed.count  # 已完成订单数
