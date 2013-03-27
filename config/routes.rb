Ahreloco::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get "users/index"
  root :to => "beta_users#new"


  match 'auth/youtube/callback' => 'sessions#create'
  match 'auth/failure' => 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout

  resources :users, only: [:show, :index] 

  resources :beta_users, only: [:new, :create, :show] 

  resources :home, only: [:index]

  resources :videos , only: [:index,:new, :create] do
    new do
       post :upload
       get  :save_video
    end
  end
    
  resources :comments, only: [:index, :create]
end
