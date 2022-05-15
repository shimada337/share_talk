Rails.application.routes.draw do
  root to: 'homes#top'
  
  devise_for :users, skip: [:passwords], controllers: {
   registrations: "user/registrations",
   sessions: 'user/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :house_members, only: [:destroy]
    resources :post_comments, only: [:destroy]
  end
  
  scope module: "user" do 
    patch "/users/out" => "users#out"
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      resources :house_members, only: [:new, :edit, :update, :create, :destroy]
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end
  
  devise_scope :user do
      post 'users/guest_sign_in' => 'user/sessions#guest_sign_in'
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
