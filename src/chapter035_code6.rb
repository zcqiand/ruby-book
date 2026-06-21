# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :available, -> { where('stock > 0') }
  scope :cheap, -> { where('price < 100') }
end