Rails.application.routes.draw do
	
  get 'messages/sent'
  get 'messages/reply'
  
  resources :messages
  devise_for :users
  resources :textbooks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'textbooks#index'
  post 'pages/rate'
  get 'pages/about'
  get 'pages/error'
  get 'pages/account'
  get 'pages/my_listings'
  get 'pages/faq'
 
  
end
