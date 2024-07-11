Rails.application.routes.draw do
  devise_for :users
  root to: "services#index"

  resources :users, only: %i[show index] do
    member do
      get 'chef', to: 'users#chef'
      get 'bookings', to: 'users#bookings'
      get 'myservices', to: 'users#myservices'
    end
  end

  resources :services do
    resources :bookings, only: %i[new create index] do
      member do
        patch 'confirm', to: 'bookings#confirm'
      end
    end
    resources :reviews, only: %i[index create new]
  end

  resources :bookings, only: %i[index show edit update destroy] do
    collection do
      get 'past', to: 'bookings#past'
    end
  end

  resources :reviews, only: %i[show edit update destroy]

end

#previously..
# Rails.application.routes.draw do
#   devise_for :users
#   root to: "services#index"

#   resources :users, only: %i[show index] do
#     member do
#       get 'chef', to: 'users#chef'
#       get 'bookings', to: 'users#bookings'
#     end
#     collection do
#       get 'myservices', to: 'users#myservices'
#     end
#     resources :reviews, only: [:index]
#     resources :services, only: %i[index edit update new create] do
#       member do
#         get 'booking_requests', to: 'services#booking_requests'
#       end
#     end
#   end

#   resources :bookings, only: %i[index show edit update destroy] do
#     collection do
#       get 'past', to: 'bookings#past'
#     end
#   end

#   resources :services, except: %i[edit update] do
#     resources :bookings, only: %i[new create]
#     resources :reviews, only: %i[index]
#   end

#   resources :bookings, only: %i[index show edit update destroy] do
#     collection do
#       get 'past', to: 'bookings#past'
#     end
#   end

#   resources :reviews, only: %i[show edit update destroy]
# end
