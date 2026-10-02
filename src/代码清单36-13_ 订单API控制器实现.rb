# app/controllers/api/v1/orders_controller.rb
module Api
  module V1
    class OrdersController < ApplicationController
      skip_before_action :verify_authenticity_token, if: :json_request?
      before_action :authenticate_api_user!
      before_action :set_order, only: [:show, :destroy]

      # GET /api/v1/orders
      def index
        @orders = Order.where(user: current_api_user)
                       .order(created_at: :desc)
                       .includes(:order_items, :products)
        render json: {
          success: true,
          data: @orders,
          total: @orders.count
        }
      end

      # GET /api/v1/orders/:id
      def show
        render json: {
          success: true,
          data: @order,
          includes: {
            order_items: @order.order_items,
            products: @order.products
          }
        }
      end

      # POST /api/v1/orders
      def create
        service = OrderService.new(current_api_user)
        order = service.create_order(order_params)

        render json: {
          success: true,
          data: order,
          message: '订单创建成功'
        }, status: :created

      rescue InsufficientStockError => e
        render json: {
          success: false,
          error: e.message
        }, status: :unprocessable_entity

      rescue OrderConflictError => e
        render json: {
          success: false,
          error: e.message
        }, status: :conflict

      rescue => e
        Rails.logger.error "Order creation failed: #{e.message}"
        render json: {
          success: false,
          error: '订单创建失败，请稍后重试'
        }, status: :internal_server_error
      end

      # DELETE /api/v1/orders/:id
      def destroy
        service = OrderService.new(current_api_user)
        service.cancel_order(@order)
        render json: { success: true, message: '订单已取消' }
      rescue OrderNotCancellableError => e
        render json: {
          success: false,
          error: e.message
        }, status: :unprocessable_entity
      end

      private

      def set_order
        @order = Order.where(user: current_api_user).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: '订单不存在' }, status: :not_found
      end

      def order_params
        params.require(:order).permit(:shipping_address, items: [:product_id, :quantity])
      end

      def json_request?
        request.format.json?
      end

      def current_api_user
        @current_api_user ||= ApiUser.find_by(id: jwt_payload['sub'])
      end

      def jwt_payload
        @jwt_payload ||= JWT.decode(
          request.headers['Authorization']&.split(' ')&.last,
          ENV.fetch('JWT_SECRET', 'your-secret-key'),
          true,
          algorithm: 'HS256'
        )[0]
      end

      def authenticate_api_user!
        render json: { success: false, error: '未授权' }, status: :unauthorized unless jwt_payload
      rescue JWT::DecodeError
        render json: { success: false, error: 'Token 无效' }, status: :unauthorized
      end
    end
  end
end