Rails.application.routes.draw do
  resources :posts, only: [:create, :show]
  resources :comments, only: [:create, :destroy]
  resources :ratings, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
