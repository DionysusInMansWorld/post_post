Rails.application.routes.draw do
  get '/signup',        to: 'users#new'
  post '/signup',       to: 'users#create'
  get '/login',         to: 'sessions#new'
  post '/login',        to: 'sessions#create'
  post '/cookie',       to: 'cookie_users#create'
  delete '/cookie',     to: 'cookie_users#destroy'
  delete '/logout',     to: 'sessions#destroy'
  get '/help',          to: 'static_pages#help'
  get '/contact',       to: 'static_pages#contact'
  resources :users
  resources :posts,   only: [:create, :destroy, :show, :index]
  resources :topics,  only: [:index, :show]
  resources :replies, only: [:create]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
