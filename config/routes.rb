Rails.application.routes.draw do
  namespace :airline do
    root "top#index"
    get "login" => "top#login"
    resources :flights, except: [:edit, :destroy]
    resource :session, only: [:create, :destroy]
  end
end
