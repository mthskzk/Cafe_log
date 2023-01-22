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

# 　ゲストログイン用のルーティング
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  namespace :admin do
    get 'homes/top'
    resources :customers, only: [:index, :edit, :show, :update, :destroy] do
      get 'relationships/followings'
      get 'relationships/followers'
    end
    resources :posts, only: [:index, :destroy] do
      resources :post_comments, only: [:index, :destroy]
      resources :favorites, only: [:index]
    end
    get 'searches/search_sns'
    get 'searches/search_review'
    get 'searches/search_cafe'
    get 'searches/search_customer'
    resources :reviews, only: [:index, :destroy]
    resources :caves
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'searches/search_sns'
    get 'searches/search_cafe'
    get 'favorites/like'
    resources :maps, only: [:index]
    get 'posts/search'
    resources :posts, only: [:new, :index, :create, :edit, :update, :destroy] do
      resources :post_comments, only: [:index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :favorites, only: [:index]
    end
    resources :reviews, only: [:new, :create, :destroy, :edit, :update]
    get 'customers/confirm'
    resources :customers, only: [:show, :edit, :update, :destroy] do
      get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
      resource :relationships, only: [:create, :destroy]
      resources :reviews, only:[:index]
      resources :keep_caves, only: [:index]
    end
    resources :caves, only: [:index, :show] do
      get 'reviews/cafe_index'
      resource :keep_caves, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
