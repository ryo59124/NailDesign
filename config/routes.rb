Rails.application.routes.draw do

  get 'confirms/index'
# 顧客用
devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# scope module URLを変えない/ファイル構成だけ指定のパスにする
scope module: :public do
  root to: "homes#top"
  post '/guests/guest_sign_in', to: 'guests#new_guest'
  get "search" => "searches#search"

  resources :nails, only: [:index, :new, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :end_users, only: [:index, :show, :edit, :update] do
    resources :favorites, only: [:index]
    resource :relationships, only: [:create, :destroy]
    resources :chats, only: [:index]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :confirm
    end
  end
  get "/end_users/:id/unsubscribe" => "end_users#unsubscribe", as: "unsuscribe"
  patch "/end_user/withdraw" => "end_users#withdraw"


end

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get '/' => "homes#top"
  resources :end_users, only: [:index, :show, :edit, :update]
  resources :nails, only: [:index, :show, :destroy] do
    resources :comments, only: [:destroy]
  end
  get "search" => "searches#search"
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
