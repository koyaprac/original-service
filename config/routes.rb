Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :update] do
    member do
      get :myarts
    end
  end
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :articles, only: [:index, :show]
  
  get 'books', to: 'books#index'
  
  resources :user_art_connects, only: [:create, :destroy]
  resources :memos, only: [:create, :update, :destroy]
end
