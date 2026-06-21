# app/models/order_item.rb
# 订单项模型 - 关联订单和商品，记录购买详情
class OrderItem < ApplicationRecord
  belongs_to :order                                   # 订单项属于一个订单
  belongs_to :product                                 # 订单项关联一个商品

  # 验证规则
  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :unit_price, numericality: { greater_than: 0 }

  # 创建前自动设置单价为商品当前价格
  before_validation :set_unit_price

  private

  # 如果没有指定单价，则使用商品当前价格
  # 使用 || = 确保只在 unit_price 为空时才设置
  def set_unit_price
    self.unit_price ||= product.price if product
  end
end
