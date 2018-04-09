Rails.application.routes.draw do
  resources :notifications, only: [:index, :show, :destroy]

  root 'pages#home'
  resources :user, param: :username, controller: "users", shallow: true, only: :show do
    resources :posts, only: [:show, :edit, :update, :create, :destroy] do
      resources :comments, only: [:edit, :update, :create, :destroy]
    end
    member do
      get 'friends'
      get 'avatar'
    end
  end
  get "users", to: "users#index", as: :users
  get "edit_profile", to: "users#edit", as: :edit_profile
  put "update_profile", to: "users#update", as: :update_profile
  resource :avatar, only: [:update, :show]
  resource :banner, only: [:update, :show]
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy] do
     collection do
       get "sent"
       get "received"
     end
  end
  post "likes/:likeable_type/:likeable_id", to: "likes#like", as: "like"
  delete "likes/:likeable_type/:likeable_id", to: "likes#unlike", as:"unlike"
  get "/search", to: "users#search"
  devise_for :users, controllers: { registrations: "users/registrations",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
end
