Trackmetrics::Application.routes.draw do
 
  resources :domains
  devise_for :users
  
  root 'welcome#index'

end
