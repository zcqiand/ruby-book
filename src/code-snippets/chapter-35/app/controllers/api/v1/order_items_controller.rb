# app/controllers/api/v1/order_items_controller.rb
# 订单项 API 控制器 - 展示嵌套资源处理
module Api
  module V1
    class OrderItemsController < ApplicationController
      skip_before_action :verify_authenticity_token

      # POST /api/v1/orders/:order_id/order_items
      # 为订单添加商品项
      def create
        @order = Order.find(params[:order_id])
        @order_item = @order.order_items.new(order_item_params)

        if @order_item.save
          render json: {
            success: true,
            data: @order_item,
            message: '订单项添加成功'
          }, status: :created
        else
          render json: {
            success: false,
            errors: @order_item.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/orders/:order_id/order_items/:id
      # 从订单中移除商品项
      def destroy
        @order = Order.find(params[:order_id])
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy

        render json: {
          success: true,
          message: '订单项已移除'
        }
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: '订单项不存在' }, status: :not_found
      end

      private

      # 强参数
      def order_item_params
        params.require(:order_item).permit(:product_id, :quantity)
      end
    end
  end
end
