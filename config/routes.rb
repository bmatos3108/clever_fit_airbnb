Rails.application.routes.draw do
  devise_for :users
  root to: "services#index"

  resources :users, only: %i[show index] do
    member do
      get 'chef', to: 'users#chef'
    end
    resources :reviews, only: [:index]
    resources :services, only: %i[index edit update]
   # collection do
     # get 'search'
    #end
  end

  resources :bookings, only: [:index] do
    collection do
      get 'past', to: 'bookings#past'
    end
    resources :services, only: [:index]
    resources :reviews, only: %i[create new]
  end

  resources :services, except: %i[edit update] do
    resources :bookings, only: %i[new create]
    resources :reviews, only: %i[index]
  end

  resources :bookings, only: %i[index show edit update destroy] do
    collection do
      get 'past', to: 'bookings#past'
    end
  end

  resources :reviews, only: %i[show edit update destroy]
end
