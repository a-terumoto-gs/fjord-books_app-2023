Rails.application.routes.draw do
  get 'users/index'
  resources :tasks
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :books
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
