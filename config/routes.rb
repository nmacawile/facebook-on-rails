Rails.application.routes.draw do

  root 'pages#home'
  resources :user, param: :username, controller: "users", only: :show do
    resources :posts, only: [:edit, :create, :update, :delete]
  end
  devise_for :users, controllers: { registrations: "users/registrations",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
end
