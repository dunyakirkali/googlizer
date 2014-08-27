Rails.application.routes.draw do
  get 'user/activate'

  get 'user/deactivate'

  get 'pages/dashboard'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    member do
      get 'activate'
      get 'deactivate'
    end
  end
  authenticated :user do
    root :to => "pages#dashboard", as: :authenticated_root
  end
  root to: 'home#index'
  get 'home/index'
end
