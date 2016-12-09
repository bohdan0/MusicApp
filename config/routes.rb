Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:show, :create, :update, :edit, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:show, :create, :update, :edit, :destroy]
end
