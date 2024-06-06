Rails.application.routes.draw do
  devise_for :users
  
  # ユーザー関連のルーティング
  resources :users, only: [:show, :edit, :update]

  # 部屋関連のルーティング
  resources :rooms, only: [:index, :show, :new, :create] do
    collection do
      get 'search'
    end
  end
  # 予約関連のルーティング
  resources :reservations, only: [:index, :new, :create, :show, :update] do
    member do
      get 'confirm', to: 'reservations#confirm'
    end
  end
  
  # 検索用ルーティング
  get 'search', to: 'rooms#search'

  # ルートパスの設定
  root to: 'welcome#index'
end
