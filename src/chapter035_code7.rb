# app/controllers/api/v1/products_controller.rb
module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /api/v1/products
      def index
        @products = Product.all
        render json: {
          success: true,
          data: @products,
          total: @products.count
        }
      end

      # GET /api/v1/products/:id
      def show
        render json: {
          success: true,
          data: @product
        }
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
            errors: @product.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/products/:id
      def update
        if @product.update(product_params)
          render json: {
            success: true,
            data: @product,
            message: '商品更新成功'
          }
        else
          render json: {
            success: false,
            errors: @product.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/products/:id
      def destroy
        @product.destroy
        render json: {
          success: true,
          message: '商品删除成功'
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
    end
  end
end