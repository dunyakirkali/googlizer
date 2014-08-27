Rails.application.routes.draw do
  get 'pages/dashboard'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  authenticated :user do
    root :to => "pages#dashboard", as: :authenticated_root
  end
  root to: 'home#index'
  get 'home/index'
end
