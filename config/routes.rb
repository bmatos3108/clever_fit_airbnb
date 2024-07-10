Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  #resources :users, only: [:show, :index] do
   # resources :reviews, only: [:index]  # Nested route to show reviews for a user
    #resources :services, only: [:index] # Nested route to show services created by a user
  #end

  # Resources for Bookings
  resources :bookings

  # Resources for Services
  resources :services do
    resources :reviews, only: [:index, :create, :new] # Nested route to show and create reviews for a service
  end

  # Resources for Reviews
  resources :reviews, only: [:show, :edit, :update, :destroy]

 end
