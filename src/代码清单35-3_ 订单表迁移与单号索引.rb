# db/migrate/20240621000002_create_orders.rb
class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false
      t.string :order_number, null: false
      t.integer :status, default: 0
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.text :shipping_address
      t.timestamps
    end

    add_index :orders, :order_number, unique: true
  end
end