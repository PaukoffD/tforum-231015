Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  resources :users, only: [:index, :show]
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :categories
  resources :groups
  resources :forums do
    resources :topics, shallow: true do
      resources :posts, shallow: true
    end
  end
  resources :users do
    resources :private_posts
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  root 'forums#index'
  get 'sitemap' => 'forums#sitemap'
  get 'latest', to: 'topics#index'
  get 'search', to: 'topics#index', as: :search
  get 'top', to: 'topics#top'
  get 'tools', to: 'tools#index'
  get 'forumtools', to: 'forums#tools'
  get 'indextopic', to: 'topics#indextopic'
  get 'tags/:tag', to: 'topics#index', as: :tag
  get 'addingroup', to: 'groups#add'
  get 'hidden_forum', to: 'groups#hidden'
end
