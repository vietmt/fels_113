Rails.application.routes.draw do
  namespace :admin do
    root "categories#index"
    resources :categories
    resources :users, only: [:index, :destroy]
  end
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  resources :users, except: :destroy
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
end
