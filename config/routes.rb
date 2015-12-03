Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
 
  resources :categories
  resources :forums do 
   resources :topics , shallow: true do
    resources :posts, shallow: true
	end
	end
 resources :users do 	
   resources :private_posts 
 end  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

   root 'forums#index'
   get 'latest', to: 'topics#index'
   get 'search', to: 'topics#search'
   get 'top', to: 'topics#top'
   get 'tools', to: 'tools#index'
   get 'forumtools', to: 'forums#tools'
end
