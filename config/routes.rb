Rails.application.routes.draw do

  get 'blog_comments/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as:'about'

  resources :users, only: [:show, :edit, :update]
  resources :blogs do
    resources :blog_comments, only: [:index, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

end
