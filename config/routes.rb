Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: { registrations: "users/registrations" }
end
