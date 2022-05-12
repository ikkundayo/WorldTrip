Rails.application.routes.draw do

  namespace :public do
    get 'review_likes/create'
    get 'review_likes/destroy'
  end


  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :users, only: [:index, :update]
    resources :countries, except: [:show ]
    resources :memories, only: [:destroy]
    resources :hints, only: [:destroy]
    resources :comments, only: [:destroy]
    resources :reviews, only: [:destroy]
  end


  devise_for :users, controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions',
  passwords: 'public/passwords'
  }
  scope module: :public do
    root 'homes#top'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get :followers, on: :member
      get :followed, on: :member
    end
    resources :memories, only: [:index, :show, :new, :create, :destroy] do
      get :search
      resource :memory_likes, only: [:create, :destroy]
      resources :memory_comments, only: [:create, :destroy]
    end
    resources :hints, only: [:index, :show, :new, :create, :destroy] do
      get :search
      resource :hint_likes, only: [:create, :destroy]
      resources :hint_comments, only: [:create, :destroy]
    end
    resources :categories, only: [:create]
    resources :reviews, only: [:index, :show, :new, :create, :destroy] do
      get :search
      resource :review_likes, only: [:create, :destroy]
    end
    resources :notifications, only: :index
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
