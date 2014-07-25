require 'sidekiq/web'

Trackmetrics::Application.routes.draw do
 
  
  get "events/index"
  resources :verifications, only: [:create]
  resources :domains do
    resources :events, only: [:index]
  end

 
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :events, only: [:create]
    end
  end

  get 'about' => 'welcome#about'
  root 'welcome#index'

  match 'events' => "events#index", via: [:post, :options]
  mount Sidekiq::Web, at: '/sidekiq'

end
