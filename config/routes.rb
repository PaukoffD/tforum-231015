Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
 
  #resources :topics
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
  

  
end
