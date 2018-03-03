Rails.application.routes.draw do

  root 'pages#home'
  resources :user, param: :username, controller: "users", shallow: true, only: :show do
    resources :posts, only: [:edit, :update, :create, :destroy] do
      resources :comments, only: [:edit, :update, :create, :destroy]
    end
  end
  get "/search", to: "users#search"
  devise_for :users, controllers: { registrations: "users/registrations",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
end
