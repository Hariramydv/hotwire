Rails.application.routes.draw do
  root 'mobiles#index'
  resources :mobiles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
