# db/migrate/20240621000002_create_orders.rb
# 订单表迁移文件 - Rails 7.2 语法
# status 使用整数存储：0=待支付, 1=已支付, 2=已发货, 3=已完成
class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false  # 关联用户，外键约束
      t.string :order_number, null: false                 # 订单编号，必填且唯一
      t.integer :status, default: 0                       # 订单状态，默认待支付
      t.decimal :total_amount, precision: 10, scale: 2, null: false  # 订单总金额
      t.text :shipping_address                             # 收货地址
      t.timestamps                                        # created_at, updated_at
    end
    add_index :orders, :order_number, unique: true         # 订单号唯一索引
  end
end
