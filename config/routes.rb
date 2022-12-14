# == Route Map
#

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create]
      resources :ratings, only: [:index, :create]
      resources :ips, only: [:index]
      get 'top_posts', to: 'posts#top'
    end
  end
end
