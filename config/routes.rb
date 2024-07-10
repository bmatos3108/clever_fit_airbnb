Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[show index] do
    member do
      get 'chef', to: 'users#chef'
    end

    resources :reviews, only: [:index]
    resources :services, only: %i[index edit update]
  end

  resources :bookings do
    collection do
      get 'past', to: 'bookings#past'
    end
    resources :services, only: [:index] do
      resources :bookings, only: %i[new create]
    end
    resources :bookings, only: [:index]
  end

  resources :services, except: [:index] do
    resources :services, except: %i[index edit update] do
      resources :bookings, only: %i[new create]
      resources :reviews, only: %i[create new]
    end
  end

  resources :bookings, only: %i[index show edit update destroy] do
    collection do
      get 'past', to: 'bookings#past'
    end
  end

  resources :reviews, only: %i[show edit update destroy]
end
