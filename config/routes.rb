Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :books
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
