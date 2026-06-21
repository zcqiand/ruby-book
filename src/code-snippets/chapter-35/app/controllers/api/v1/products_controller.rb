# app/controllers/api/v1/products_controller.rb
# 商品 API 控制器 - 展示 RESTful API 的标准实现
module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token  # API 模式跳过 CSRF 验证
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /api/v1/products
      # 返回所有商品列表
      def index
        @products = Product.all
        render json: {
          success: true,
          data: @products,
          total: @products.count
        }
      end

      # GET /api/v1/products/:id
      # 返回指定商品详情
      def show
        render json: {
          success: true,
          data: @product
        }
      end

      # POST /api/v1/products
      # 创建新商品
      def create
        @product = Product.new(product_params)
        if @product.save
          # status: :created 返回 201 状态码
          render json: {
            success: true,
            data: @product,
            message: '商品创建成功'
          }, status: :created
        else
          # status: :unprocessable_entity 返回 422 状态码
          render json: {
            success: false,
            errors: @product.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/products/:id
      # 更新商品信息
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
      # 删除商品
      def destroy
        @product.destroy
        render json: {
          success: true,
          message: '商品删除成功'
        }
      end

      private

      # 使用 find 查找商品，RecordNotFound 异常由 rescue_from 处理
      def set_product
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: '商品不存在' }, status: :not_found
      end

      # 强参数：只允许传入指定字段，防止批量赋值漏洞
      def product_params
        params.require(:product).permit(:name, :description, :price, :stock)
      end
    end
  end
end
