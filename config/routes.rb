Rails.application.routes.draw do
  namespace :api do
    resources :users 
    resources :posts do
      resources :comments, only: :create
    end
    root 'posts#index'
    resource :session, only: [:new, :create, :destroy]
  end
  
end
