Rails.application.routes.draw do
  get 'friendships/create'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create] do
      collection do
        get 'accept_friend'
        get 'reject_friend'
      end
    end
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
end
