Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    root "categories#index"
    resources :categories do
      resources :words
    end
    resources :users, only: [:index, :destroy]
  end
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  resources :users do
    resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
  resources :words, only: :index
  resources :lessons
end
