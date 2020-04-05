Rails.application.routes.draw do
  devise_for :users
  get "home/about" => "homes#about"
  root 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update, :index]
  resources :books
  resource :favorite, only: [:create, :destroy]
end