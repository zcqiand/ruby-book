# app/controllers/api/v1/orders_controller.rb
# 订单 API 控制器 - 展示关联查询和嵌套路由
module Api
  module V1
    class OrdersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_order, only: [:show, :update]

      # GET /api/v1/orders
      # 返回所有订单列表
      def index
        @orders = Order.all
        render json: {
          success: true,
          data: @orders,
          total: @orders.count
        }
      end

      # GET /api/v1/orders/:id
      # 返回指定订单详情，包含订单项和商品信息
      def show
        # includes 预加载关联数据，避免 N+1 查询问题
        render json: {
          success: true,
          data: @order,
          includes: [:order_items, :products]
        }
      end

      # POST /api/v1/orders
      # 创建新订单
      def create
        @order = Order.new(order_params)
        if @order.save
          render json: {
            success: true,
            data: @order,
            message: '订单创建成功'
          }, status: :created
        else
          render json: {
            success: false,
            errors: @order.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # PATCH /api/v1/orders/:id
      # 更新订单状态（如支付、发货）
      def update
        if @order.update(order_params)
          render json: {
            success: true,
            data: @order,
            message: '订单更新成功'
          }
        else
          render json: {
            success: false,
            errors: @order.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      # 预加载关联数据
      def set_order
        @order = Order.includes(:order_items, :products).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: '订单不存在' }, status: :not_found
      end

      # 强参数：允许 user_id, status, shipping_address
      def order_params
        params.require(:order).permit(:user_id, :status, :shipping_address)
      end
    end
  end
end
