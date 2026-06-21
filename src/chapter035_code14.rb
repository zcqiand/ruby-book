class Order < ApplicationRecord
  enum :status, { pending: 0, paid: 1, shipped: 2, completed: 3, cancelled: 4 }, default: :pending

  def can_pay?
    pending?
  end

  def can_ship?
    paid?
  end

  def can_complete?
    shipped?
  end

  def can_cancel?
    pending? || paid?
  end
end