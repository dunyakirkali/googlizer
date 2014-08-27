Rails.application.routes.draw do
  get 'pages/dashboard'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'
  get 'home/index'
end
