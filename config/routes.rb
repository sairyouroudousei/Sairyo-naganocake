Rails.application.routes.draw do

     # 管理者のログイン・トップページを顧客と分ける為のもの
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_scope :admin do
    get '/admin/orders/top' => 'admin/orders#top'
  end

  # 顧客テーブル
  devise_for :customers
  get '/customers/withdraw' => 'customers#withdraw'
  resources :customers, only: [:show, :edit, :update] do
    collection do
      patch 'active'
    end
  end
  namespace :admin do
    resources :customers
  end

  # 商品テーブル
  root to: 'items#top'
  resources :items, only: [:index, :show], param: :id

  # カートテーブル
  resources :carts, only: [:index,:destroy]
  post '/cart_item' => 'carts#create', as: 'cart_item'
  patch '/carts/:cart_item_id' => 'carts#update_item', as: 'update_item'
  delete '/delete_item/:cart_item_id' => 'carts#delete_item', as: 'delete_item'

  # 配送先テーブル
  resources :addresses

  # 注文テーブル
# resources :orders
get '/orders/thanks' => 'orders#thanks'
resources :orders, only: [:new, :index, :create]


  namespace :admin do
    #admin側のorderテーブル
    resources :orders, only: [:update, :index, :show] 
    resources :order_details, only: [:update]
    resources :genres
    resources :items
  end

  # 注文テーブル
  get '/orders/thank' => 'orders#thank'
  resources :orders
  
  
  # 注文明細テーブル
  resources :order_details, only: [:index, :show]

  namespace :admin do
    get 'order_details/edit'
    get 'order_details/index'
  end

  # 検索用
  get '/search', to: 'search#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end