Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users, only: [:show, :index] do
    resources :reviews, only: [:index]  # Nested route to show reviews for a user
    resources :services, only: [:index] # Nested route to show services created by a user
  end

  # Resources for Bookings
  resources :bookings

  # Resources for Services
  resources :services do
    resources :reviews, only: [:index, :create, :new] # Nested route to show and create reviews for a service
  end

  # Resources for Reviews
  resources :reviews, only: [:show, :edit, :update, :destroy]

  # Root path
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
