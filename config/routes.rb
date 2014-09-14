Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    member do
      get 'activate'
      get 'deactivate'
    end
    resources :searches
  end

  authenticated :user do
    root :to => "home#dashboard", as: :authenticated_root
  end
  root to: 'home#index'
end
