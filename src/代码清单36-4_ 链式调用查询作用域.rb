def index
  @products = Product.available.in_category(params[:category])
  render json: @products
end