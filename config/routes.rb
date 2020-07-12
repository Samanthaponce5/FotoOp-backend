Rails.application.routes.draw do
  resources :pictures
  resources :comments
  resources :likes
  resources :pictures, only: [:create, :index]

  get '/profile' => 'users#show', as: 'profile'

  resources :users, only: [:create, :index]
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  get "/user_is_authed", to: "auth#user_is_authed"
  
end
