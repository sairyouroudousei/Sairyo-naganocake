Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }


scope module: :public do
  root to:"home#top"
  get "about" => "home#about"
  resources :items, only: [:index, :show]
#customersコントローラのルーティング
  get "customers/my_page" => "customers#show", as: "my_page"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"
  get "customers/unsubscribe" => "customers#unsubscribe"
  patch "customers/withdraw" => "customers#withdraw"
#cart_itemsコントローラのルーティング
  delete "cart_items/destroy_all" => "cart_items#destroy_all"
  resources :cart_items, only: [:index, :update, :destroy, :create]
#ordersコントローラのルーティング
  get "orders/complete" => "orders#complete"
  resources :orders, only: [:new, :create, :index, :show]
  post "orders/confirm" => "orders#confirm"
  

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end


namespace :admin do
  root to: "homes#top"
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]

  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]
end

end