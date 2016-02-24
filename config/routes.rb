Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :users
 # devise_for :admin
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
   get 'sitemap' => 'forums#sitemap'
   get 'latest', to: 'topics#index'
   get 'search', to: 'topics#index', via: [:get, :post], as: :search
   get 'top', to: 'topics#top'
   get 'tools', to: 'tools#index'
   get 'forumtools', to: 'forums#tools'
   get 'indextopic', to: 'topics#indextopic'
end
