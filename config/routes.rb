Rails.application.routes.draw do
  resources :messages
  devise_for :users
  resources :textbooks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'textbooks#index'
  get 'pages/about'
  get 'pages/error'
  get 'pages/account'
  get 'pages/my_listings'
  
end
