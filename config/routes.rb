Trackmetrics::Application.routes.draw do
 
  
  resources :verifications, only: [:create]
  resources :domains
  devise_for :users
  get 'about' => 'welcome#about'
  root 'welcome#index'

end
