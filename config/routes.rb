# config/routes.rb
Rails.application.routes.draw do
  root 'sessions#new'
  
  # Authentication
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # User registration and password change
  resources :users, only: [:new, :create, :edit, :update]
  
  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  
  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users
    resources :stores
  end
  
  # Store owner routes
  namespace :store_owner do
    get 'dashboard', to: 'dashboard#index'
  end
  
  # Normal user routes
  resources :stores, only: [:index, :show] do
    resources :ratings, only: [:create, :update]
  end
end
