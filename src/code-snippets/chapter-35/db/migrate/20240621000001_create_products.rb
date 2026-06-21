# db/migrate/20240621000001_create_products.rb
# 商品表迁移文件 - 使用 Rails 7.2 Migration API
# precision: 10 表示总位数，scale: 2 表示小数点后两位
class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false                    # 商品名称，必填
      t.text :description                            # 商品描述，可为空
      t.decimal :price, precision: 10, scale: 2, null: false  # 价格，精确到分
      t.integer :stock, default: 0, null: false      # 库存，默认0
      t.timestamps                                   # 自动创建 created_at 和 updated_at
    end
    add_index :products, :name                       # 为名称字段添加索引，加速查询
  end
end
