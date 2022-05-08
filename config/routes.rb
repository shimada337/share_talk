Rails.application.routes.draw do
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :user do
    get 'house_members/new'
    get 'house_members/edit'
  end
  namespace :user do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :user do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  get 'homes/top'
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
