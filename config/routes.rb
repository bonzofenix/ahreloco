Ahreloco::Application.routes.draw do
  get "users/index"

  root :to => "home#index"
  match 'auth/youtube/callback' => 'sessions#create'
  match "/signout" => "sessions#destroy", :as => :signout
  resources :users, only: [:show, :index] 

  resources :videos , only: [:new, :create] do
    new do
       post :upload
       get  :save_video
    end
  end
    
  resources :comments, only: [:index, :create]
end
