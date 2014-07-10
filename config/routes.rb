Trackmetrics::Application.routes.draw do
 
  
  resources :verifications, only: [:create]
  resources :domains
  
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :events, only: [:create]
    end
  end

  get 'about' => 'welcome#about'
  root 'welcome#index'

  match 'events' => "events#index", via: :options

end
