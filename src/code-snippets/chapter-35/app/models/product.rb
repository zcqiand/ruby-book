# app/models/product.rb
# 商品模型 - 展示 Rails 模型的基本配置
class Product < ApplicationRecord
  # has_many :order_items 允许 Product 通过 OrderItem 访问关联的 Order
  # has_many :orders, through: :order_items 建立多对多关系
  has_many :order_items
  has_many :orders, through: :order_items

  # 验证规则：确保数据完整性
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # 作用域：用于链式查询，使代码更简洁
  scope :available, -> { where('stock > 0') }           # 有库存的商品
  scope :cheap, -> { where('price < 100') }              # 价格低于100的商品
  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }  # 按名称模糊搜索
end
