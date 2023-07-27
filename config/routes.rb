Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # resources :reservations
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/member-data', to: 'members#show'
  # resources :rooms
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # make namespace for api/v1
  namespace :api do
    namespace :v1 do
      resources :rooms
      resources :reservations
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
