# == Route Map
#

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/posts', to: 'api/v1/posts#index'
  post '/posts', to: 'api/v1/posts#create'
end
