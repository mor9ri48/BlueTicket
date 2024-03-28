Rails.application.routes.draw do
  root "top#index"
  resources :flights, only: [:index, :show] do
    get "search", on: :collection
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resources :customers, only: [:new, :create, :destroy] do
    get "login", on: :collection
    resources :bookings, only: [:index, :show, :destroy] do
      get "checkin", on: :member
    end
  end
  resources :booking_seat_flights, only: [:new, :create, :update] do
    get "seatChoice", on: :collection
  end

  namespace :admin do
    root "top#index"
    get "login" => "top#login"
    resources :customers, only: [:index, :show, :destroy] do
      get "search", on: :collection
      resources :bookings, except: [:new, :edit, :create] do
        get "checkin", on: :member
      end
    end
    resources :booking_seat_flights, only: [:update]
    resource :session, only: [:create, :destroy]
  end

  namespace :airline do
    root "top#index"
    get "login" => "top#login"
    resources :flights, except: [:edit, :destroy] do
      get "search", on: :collection
      get "wholeCheckin", on: :member
    end
    resource :session, only: [:create, :destroy]
  end
end
