Rails.application.routes.draw do
  resources :filters
  resources :filter_groups
  resources :select_fields
  resources :odata_requests
  resources :credentials
  resources :collections
  resources :urls
  get 'odata/process_url', to: 'odata#process_url'
  get 'odata/test_url', to: 'odata#test_url'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "collections#index"
end
