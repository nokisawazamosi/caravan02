Rails.application.routes.draw do


  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as:'about'

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :blogs do
    resources :blog_comments, only: [:index, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  get '/search' => 'searches#search'

end
