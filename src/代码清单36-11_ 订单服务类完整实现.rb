# app/services/order_service.rb
class OrderService
  def initialize(user)
    @user = user
  end

  def create_order(params)
    ActiveRecord::Base.transaction do
      order = Order.create!(
        user: @user,
        total_amount: 0,
        shipping_address: params[:shipping_address],
        status: :pending
      )

      total = 0
      items_params = params[:items] || []

      items_params.each do |item_params|
        # 悲观锁查询商品，锁定该行
        product = Product.lock.find(item_params[:product_id])

        # 业务校验
        raise InsufficientStockError, "商品[#{product.name}]库存不足" if product.stock < item_params[:quantity]

        # 扣减库存
        product.with_lock do
          product.stock -= item_params[:quantity]
          product.save!
        end

        # 创建订单项
        OrderItem.create!(
          order: order,
          product: product,
          quantity: item_params[:quantity],
          unit_price: product.price
        )

        total += product.price * item_params[:quantity]
      end

      order.update!(total_amount: total)
      order
    end
  rescue ActiveRecord::StaleObjectError
    # 乐观锁冲突重试，最多3次
    @retry_count ||= 0
    @retry_count += 1
    if @retry_count < 3
      retry
    else
      raise OrderConflictError, "订单处理并发冲突，请稍后重试"
    end
  end
end