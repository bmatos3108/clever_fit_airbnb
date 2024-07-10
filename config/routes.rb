Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[show index] do
    member do
      get 'chef', to: 'users#chef'
    end
    resources :reviews, only: [:index]
    resources :services, only: [:index] do
      resources :bookings, only: %i[new create]
    end
    resources :bookings, only: [:index]
  end

  resources :services, except: [:index] do
    resources :reviews, only: %i[create new] # Nested route to show and create reviews for a service
  end


  resources :bookings, only: %i[index show edit update destroy] do
    collection do
      get 'past', to: 'bookings#past'
    end
  end

  resources :reviews, only: %i[show edit update destroy]

end
