# db/seeds.rb
Product.delete_all
Order.delete_all
OrderItem.delete_all

products = Product.create!([
  { name: 'iPhone 15 Pro', description: 'Apple最新旗舰手机', price: 7999.00, stock: 100 },
  { name: 'MacBook Air M3', description: '轻薄高性能笔记本', price: 9999.00, stock: 50 },
  { name: 'AirPods Pro 2', description: '主动降噪无线耳机', price: 1899.00, stock: 200 },
  { name: 'iPad Air', description: '10.9英寸全面屏平板', price: 4799.00, stock: 80 }
])

puts "Created #{products.count} products"