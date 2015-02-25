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
   resources :tag
   resources :position
   resources :creator
    post '/auth' => 'api#api_auth'
 end
  
  get 'api/api/nearby' => 'api/api#nearby'
  
   # This route is for JWT login


end
