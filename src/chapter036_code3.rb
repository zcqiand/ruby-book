class Product < ApplicationRecord
  # 有库存的商品
  scope :available, -> { where('stock > 0') }
  # 按分类筛选
  scope :in_category, ->(cat) { where(category: cat) }
  # 价格区间
  scope :price_range, ->(min, max) { where(price: min..max) }
end