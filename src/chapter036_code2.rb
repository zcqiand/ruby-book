class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end