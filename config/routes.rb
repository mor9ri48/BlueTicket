Rails.application.routes.draw do
  root "top#index"
  resources :flights, only: [:index] do
    get "search", on: :collection
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resources :customers, only: [:new, :create, :destroy] do
    get "login", on: :collection
    resources :bookings, except: [:edit] do
      get "checkin", on: :member
    end
  end

  namespace :admin do
    root "top#index"
    get "login" => "top#login"
    resources :customers, only: [:index, :show, :destroy] do
      get "search", on: :collection
      resources :bookings, except: [:new, :edit, :create]
    end
    resource :session, only: [:create, :destroy]
  end

  namespace :airline do
    root "top#index"
    get "login" => "top#login"
    resources :flights, except: [:edit, :destroy]
    resource :session, only: [:create, :destroy]
  end
end
