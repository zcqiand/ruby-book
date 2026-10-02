resources :users do
  member do
    post :follow
    delete :unfollow
  end
end