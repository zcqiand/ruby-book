# db/migrate/20240621000003_create_order_items.rb
# 订单项表迁移文件 - 实现多对多关联
# 订单项连接订单和商品，记录每件商品的购买数量和单价
class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true, null: false   # 关联订单
      t.references :product, foreign_key: true, null: false # 关联商品
      t.integer :quantity, null: false                      # 购买数量
      t.decimal :unit_price, precision: 10, scale: 2, null: false  # 购买时单价
      t.timestamps
    end
  end
end
