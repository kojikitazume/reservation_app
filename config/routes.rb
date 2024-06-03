Rails.application.routes.draw do
  devise_for :users
  
  # ユーザー関連のルーティング
  resources :users, only: [:show, :edit, :update]

  # 部屋関連のルーティング
  resources :rooms, only: [:index, :show, :new, :create]

  # 予約関連のルーティング
  resources :reservations, only: [:index, :new, :create, :show] do
    collection do
      post 'confirm'  
    end
  end
  post 'reservations/confirm', to: 'reservations#confirm', as: :confirm_reservation
  # 検索用ルーティング
  get 'search', to: 'rooms#search'

  # ルートパスの設定
  root to: 'welcome#index'
end



