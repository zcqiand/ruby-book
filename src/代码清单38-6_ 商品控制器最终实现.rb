# app/controllers/api/products_controller.rb
# 商品控制器：继承认证基类，自动要求 JWT 认证

class Api::ProductsController < Api::ApplicationController
  # GET /api/products
  def index
    # 使用 @current_user_id（由 ApplicationController 设置）
    # 可基于当前用户筛选商品
    products = Product.all

    render json: {
      data: products.map { |p| {
        id: p.id,
        name: p.name,
        price: p.price,
        stock: p.stock
      }},
      pagination: {
        current_page: 1,
        total_pages: 1,
        total_count: products.count
      }
    }
  end

  # GET /api/products/:id
  def show
    product = Product.find(params[:id])
    render json: { data: product }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
  end

  # POST /api/products
  def create
    product = Product.new(product_params)

    if product.save
      render json: { data: product }, status: :created
    else
      render json: { error: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # 强参数：防止批量赋值攻击
  def product_params
    params.require(:product).permit(:name, :price, :stock, :category)
  end
end