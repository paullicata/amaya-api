Rails.application.routes.draw do

  resources :liked_books
  resources :authors
  resources :books
  devise_for :users,
             controllers: {
                 registrations: :registrations,
                 sessions: :sessions
             }


  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  patch 'users/:id', to: 'users#update'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
end
