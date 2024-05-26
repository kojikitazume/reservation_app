Rails.application.routes.draw do
  devise_for :users
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'reservations/index'
  get 'reservations/new'
  get 'reservations/create'
  get 'rooms/index'
  get 'rooms/show'
  get 'rooms/new'
  get 'rooms/create'
  get 'rooms/edit'
  get 'rooms/update'
  
  root to: 'welcome#index'

  resources :users, only: [:show, :edit, :update]
  resources :rooms do
    resources :reservations, only: [:new, :create, :index]
  end
end
