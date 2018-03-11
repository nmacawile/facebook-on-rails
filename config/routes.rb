Rails.application.routes.draw do
  root 'pages#home'
  resources :user, param: :username, controller: "users", shallow: true, only: :show do
    resources :posts, only: [:edit, :update, :create, :destroy] do
      resources :comments, only: [:edit, :update, :create, :destroy]
    end
    member do
      get 'friends'
    end
  end
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy] do
     collection do
       get "sent"
       get "received"
     end
  end
  post "likes/:likeable_type/:likeable_id", to: "likes#like", as: "like"
  delete "likes/:likeable_type/:likeable_id", to: "likes#unlike", as:"unlike"
  get "/search", to: "users#index"
  devise_for :users, controllers: { registrations: "users/registrations",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
end
