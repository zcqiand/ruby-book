# config/routes.rb
resources :users, only: [:show, :index] do
  member do
    post 'follow', to: 'follows#create'
    delete 'follow', to: 'follows#destroy', as: 'unfollow'
  end
  collection do
    get 'followers', to: 'users#followers'
    get 'following', to: 'users#following'
  end
end

get '/timeline', to: 'timelines#show', as: :timeline