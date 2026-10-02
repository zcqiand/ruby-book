# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products do
        member do
          get :stock_check, on: :member
        end
        collection do
          get :available, on: :collection
        end
      end

      resources :orders do
        resources :order_items, only: [:create, :destroy]
      end
    end
  end
end