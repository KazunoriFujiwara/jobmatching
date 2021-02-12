Rails.application.routes.draw do

  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :undertakes
      get :searches
    end
  end

  get 'corporation', to: 'users#corporationes'
  get 'apply', to: 'users#applies'
  get 'applier', to: 'companies#appliers'
  get 'clogin', to: 'sessions#c_new'
  post 'clogin', to: 'sessions#c_create'
  delete 'clogout', to: 'sessions#c_destroy'
  get 'confirm', to: 'jobs#confirm'
  
  get 'csignup', to: 'companies#new'
  resources :companies, only: [:index, :show, :new, :create, :update]
  resources :relationships, only: [:create, :destroy, :update]
  resources :jobs, only: [:new, :show, :create, :destroy, :update]
  
end
