# config/routes.rb
# 路由配置 - 展示 Rails API 命名空间和嵌套资源
Rails.application.routes.draw do
  # API 版本 1 的路由
  namespace :api do
    namespace :v1 do
      # resources 自动生成 7 个 RESTful 路由：
      # products GET/POST        -> index, create
      # products GET/PUT/DELETE  -> show, update, destroy
      resources :products

      # orders 路由，嵌套 order_items
      # order_items 仅暴露 create 和 destroy 操作
      resources :orders do
        resources :order_items, only: [:create, :destroy]
      end
    end
  end
end

# 生成的路由清单：
# GET    /api/v1/products          -> products#index
# POST   /api/v1/products          -> products#create
# GET    /api/v1/products/:id      -> products#show
# PUT    /api/v1/products/:id      -> products#update
# DELETE /api/v1/products/:id      -> products#destroy
# GET    /api/v1/orders            -> orders#index
# POST   /api/v1/orders            -> orders#create
# GET    /api/v1/orders/:id        -> orders#show
# PATCH  /api/v1/orders/:id        -> orders#update
# POST   /api/v1/orders/:order_id/order_items      -> order_items#create
# DELETE /api/v1/orders/:order_id/order_items/:id  -> order_items#destroy
