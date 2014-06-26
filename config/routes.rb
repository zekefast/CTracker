Rails.application.routes.draw do
  devise_for :users
  root to: "currencies#index"

  resources :countries, except: [:new, :create, :destroy]

  resources :currencies, only: [:index, :show]
end
