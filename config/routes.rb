Rails.application.routes.draw do

  resources :authors
  resources :books
  devise_for :users,
             controllers: {
                 registrations: :registrations,
                 sessions: :sessions
             }
end
