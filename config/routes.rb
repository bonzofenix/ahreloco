Ahreloco::Application.routes.draw do
  get "users/index"

  root :to => "home#index"
  match 'auth/youtube/callback' => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout
  resources :users, only: [:show, :index]
end
