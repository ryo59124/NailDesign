Rails.application.routes.draw do

# 顧客用
devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# scope module URLを変えない/ファイル構成だけ指定のパスにする
scope module: :public do
  root to: "homes#top"
  get 'relationships/followings'
  get 'relationships/followers'
  get "search" => "searches#search"
  
  resources :nails, only: [:index, :new, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
#chatの一覧は出せない？

  resources :end_users, only: [:index, :show, :edit, :update]
  #get "/end_users/my_page" => "end_users#show"
  #get "/end_users" => "end_users#show"
  #get "/end_users/information/edit" => "end_users#edit"
  #patch "end_users/information" => "end_users#update"
  get "/end_users/unsubscribe" => "end_users#unsubscribe"
  patch "/end_user/withdraw" => "end_users#withdraw"

end

 devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
 end
  
# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get '/' => "homes#top"
  resources :end_users, only: [:index, :show, :edit, :destroy]
  #退会表記に変える？削除？
  resources :nails, only: [:index, :show, :destroy] do
    resources :comments, only: [:destroy]
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
