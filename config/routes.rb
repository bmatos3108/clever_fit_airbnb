Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[show index] do
    member do
      get 'chef', to: 'users#chef'
    end
    resources :reviews, only: [:index]
    resources :services, only: [:index]
  end

  resources :bookings do
    collection do
      get 'past', to: 'bookings#past'
    end
  end

  resources :services, except: [:index] do
    resources :reviews, only: %i[create new]
  end

  resources :reviews, only: %i[show edit update destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
