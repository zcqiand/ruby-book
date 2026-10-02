# app/controllers/api/v1/products_controller.rb
module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token, if: :json_request?
      before_action :set_product, only: [:show, :update, :destroy, :stock_check]

      # GET /api/v1/products
      def index
        @products = Product.all
        @products = @products.where('stock > 0') if params[:available] == 'true'
        @products = @products.order(created_at: :desc).limit(50)

        render json: {
          success: true,
          data: @products,
          total: @products.count
        }
      end

      # GET /api/v1/products/:id
      def show
        render json: { success: true, data: @product }
      end

      # POST /api/v1/products
      def create
        @product = Product.new(product_params)
        if @product.save
          render json: {
            success: true,
            data: @product,
            message: '商品创建成功'
          }, status: :created
        else
          render json: {
            success: false,
            error: @product.errors.full_messages.join(', ')
          }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/products/:id
      def update
        if @product.update(product_params)
          render json: { success: true, data: @product, message: '商品更新成功' }
        else
          render json: {
            success: false,
            error: @product.errors.full_messages.join(', ')
          }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/products/:id
      def destroy
        if @product.order_items.any?
          render json: {
            success: false,
            error: '该商品存在关联订单，无法删除'
          }, status: :unprocessable_entity
        else
          @product.destroy
          render json: { success: true, message: '商品已删除' }
        end
      end

      # GET /api/v1/products/:id/stock_check
      def stock_check
        render json: {
          success: true,
          data: {
            product_id: @product.id,
            name: @product.name,
            stock: @product.stock,
            available: @product.stock > 0
          }
        }
      end

      private

      def set_product
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: '商品不存在' }, status: :not_found
      end

      def product_params
        params.require(:product).permit(:name, :description, :price, :stock)
      end

      def json_request?
        request.format.json?
      end
    end
  end
end