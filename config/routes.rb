Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :comments

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :blogs
  get 'signup', to: 'users#new'

  resources :users, except: [:new]
  # Defines the root path route ("/")
  root "home#index"
  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'
end
