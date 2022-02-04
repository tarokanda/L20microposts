Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
    end
    collection do
      get :search
    end
  end
  
  
  #お気に入り登録の設定
  resources :users, only: [:index, :show, :create] do
    member do
      get :likings
      get :likes
    end
  end
  
  
  

  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  #お気に入り登録の設定
  resources :favorites, only: [:create, :destroy]

  
end