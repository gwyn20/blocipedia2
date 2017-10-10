Rails.application.routes.draw do
  
  resources :collaborators

  get 'charges/new'

  get 'charges/downgrade'

  resources :wikis

  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  devise_for :users
  
  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :users, only: [:new, :create]
  
  resources :charges, only: [:new, :create, :downgrade] 
  
end
