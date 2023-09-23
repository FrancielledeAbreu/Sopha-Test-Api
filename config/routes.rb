Rails.application.routes.draw do
  post '/register', to: 'authentication#register'
  post '/login', to: 'authentication#login'
  get '/user', to: 'users#show'
  get '/user/stores', to: 'users#stores'
  resources :stores
end
