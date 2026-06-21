# app/models/order.rb
# 订单模型 - 展示 enum、before_validation 和复杂业务逻辑
class Order < ApplicationRecord
  belongs_to :user                                    # 每个订单属于一个用户
  has_many :order_items, dependent: :destroy          # 订单项随订单一起删除
  has_many :products, through: :order_items            # 通过订单项访问商品

  # 枚举类型：将 status 字段映射到有意义的名称
  # Rails 自动生成 pending?, paid?, shipped?, completed? 方法
  enum :status, { pending: 0, paid: 1, shipped: 2, completed: 3 }, default: :pending

  # 验证规则
  validates :order_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: 0..3 }

  # 创建前自动生成订单号
  before_validation :generate_order_number, on: :create

  # 计算订单总金额（基于订单项）
  def total_amount
    # sum 方法遍历所有订单项，计算 quantity * unit_price 的总和
    order_items.sum { |item| item.quantity * item.unit_price }
  end

  private

  # 生成唯一订单号：ORD-时间戳-随机字符串
  # 使用 || = 确保只在订单号为空时才生成
  def generate_order_number
    self.order_number ||= "ORD-#{Time.current.strftime('%Y%m%d%H%M%S')}-#{SecureRandom.hex(4).upcase}"
  end
end
