Rails.application.routes.draw do
  get 'companies/index'
  get 'companies/show'
  get 'companies/new'
  get 'companies/create'
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  
  get 'corporation', to: 'users#corporationes'
  get 'clogin', to: 'sessions#c_new'
  post 'clogin', to: 'sessions#c_create'
  delete 'clogout', to: 'sessions#c_destroy'
  
  get 'csignup', to: 'companies#new'
  #get 'login', to: 'companies#sign_in'
  resources :companies, only: [:index, :show, :new, :create]
end
