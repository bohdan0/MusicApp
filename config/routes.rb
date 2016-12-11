Rails.application.routes.draw do
  root "bands#index"
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new, :create]
  end

  resources :albums, only: [:show, :update, :edit, :destroy] do
    resources :tracks, only: [:new, :create]
  end

  resources :tracks, only: [:show, :update, :edit, :destroy]
end
