Rails.application.routes.draw do

  root "staticpage#home"

  get '/helf', to: 'staticpage#help', as: 'helf'

  get 'about', to: 'staticpage#about'

  get '/contact', to: 'staticpage#contact'

  get '/signup', to: 'users#new'

  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#creater'

  get 'auth/failure', to: redirect('/')
  resources :users

  resources :users do
    member do
      get :following
      get :followers
    end
  end

  resources :microposts do
    resources :comments
  end

  resources :microposts do
    member do
      put 'like' => 'microposts#vote'
    end
  end

  resources :relationships,       only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
