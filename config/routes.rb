Rails.application.routes.draw do
  
  get 'charges/new'

  get 'charges/downgrade'

  resources :wikis

  devise_for :users
  
  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :users, only: [:new, :create]
  
  resources :charges, only: [:new, :create, :downgrade]  

  
end
