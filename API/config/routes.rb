Rails.application.routes.draw do

  root :to => redirect('/login')
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout'  => 'session#destroy'
  get '/delete' => 'users#destroy'
  post '/users/:id' => 'users#generate_API'
  resources :users
  
 namespace :api do
   resources :api
 end
  
   #get '/api' => 'position#index'

end
