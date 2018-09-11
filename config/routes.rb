Rails.application.routes.draw do
  namespace :api do
    resources :users do
      resources :posts, only: [:show, :destroy]
    end
    root 'posts#index'
    resources :posts, only: [:create, :show] do
      resources :comments, only: :create
    end
    resource :session, only: [:create, :destroy]
  end
  
end
