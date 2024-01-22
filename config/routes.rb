Rails.application.routes.draw do
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
