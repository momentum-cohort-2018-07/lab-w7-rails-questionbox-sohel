Rails.application.routes.draw do
    resources :users 
    resources :posts do
      resources :comments, only: [:create, :new]
    end
    root 'posts#index'
    resource :session, only: [:new, :create, :destroy]
    
    namespace :api do
      namespace :v1 do
        resources :users
        resources :posts do
          resources :comments, only: [:create, :new]
        end
        root 'posts#index'
        resource :session, only: :create
      end
    end    
  end
