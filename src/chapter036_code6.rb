def create
  ActiveRecord::Base.transaction do
    # 1. 查询商品并锁定（后面讲锁）
    product = Product.lock.find(params[:product_id])

    # 2. 检查库存
    raise ActiveRecord::Rollback, '库存不足' if product.stock < params[:quantity]

    # 3. 扣减库存
    product.stock -= params[:quantity].to_i
    product.save!

    # 4. 创建订单
    order = Order.create!(
      user_id: current_user.id,
      total_price: product.price * params[:quantity].to_i,
      status: :pending
    )

    # 5. 创建订单项
    OrderItem.create!(
      order_id: order.id,
      product_id: product.id,
      quantity: params[:quantity],
      price: product.price
    )

    render json: order, status: :created
  end
rescue ActiveRecord::Rollback => e
  render json: { error: e.message }, status: :unprocessable_entity
end