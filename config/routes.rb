Rails.application.routes.draw do

  root to: "public/homes#top"

  # 顧客用サインイン・サインアップ
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用サインイン
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top'
    resources :customers, only: [:index, :edit, :show, :update] do
      get 'relationships/followings'
      get 'relationships/followers'
    end
    get 'posts/confirm'
    resources :posts, only: [:index, :destroy] do
      resources :post_comments, only: [:index, :destroy]
      resources :favorites, only: [:index]
    end
    get 'searches/search_sns'
    get 'searches/search_review'
    get 'searches/search_cafe'
    get 'reviews/confirm'
    resources :reviews, only: [:index, :destroy]
    get 'post_comments/confirm'
    get 'caves/unsubscribe'
    patch 'caves/withdrawal'
    resources :caves, only: [:new, :index, :create, :edit, :show, :update]
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'searches/search_sns'
    get 'searches/search_review'
    get 'searches/search_cafe'
    get 'favorites/like'
    resources :maps, only: [:index]
    resources :posts, only: [:new, :index, :create, :destroy] do
      resources :post_comments, only: [:index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :favorites, only: [:index]
    end
    resources :reviews, only: [:new, :index, :create, :destroy]
    resources :keep_caves, only: [:index, :create, :destroy]
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    resources :customers, only: [:show, :edit, :update] do
      get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
      resource :relationships, only: [:create, :destroy]
    end
    resources :caves, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
