Rails.application.routes.draw do
  devise_for :users
   root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Bookings/Home page:
  # As a visitor I can search for an animal
  # As a visitor I can browse between animals
  # root "pets#index"
  # # As a user I can create a profile for my pet
  # get 'pets/new', to: 'pets#new'
  # post 'pets', to: 'pets#create'
  # # As a user I can rent an emotional support animal
  # get 'pets/:id', to: 'pets#show'
  # # As a user I can create a profile for myself
  # # get 'users/new', to: 'users#new'
  # # post 'users', to: 'users#create'
  # # As a user I can accept/decline the booking
  # get 'bookings/new', to: 'bookings#new'
  # post 'bookings', to: 'bookings#create'
  # get 'bookings/:id/edit', to: 'bookings#edit'
  # patch 'bookings/:id', to: 'bookings#update'
  # # As a user I can view my dashboard
  # get 'dashboard', to: 'pages#dashboard'

  # resources :pets, only: [:new, :create, :show] do
  #   resources :bookings, only: [:new, :create, :edit, :update]
  # end

  # placeholder resources that we can work on each model in parallel
   resources :pets do
     resources :bookings, except: [:destroy]
   end
   resources :bookings, only: [:destroy]
  resources :pages
# get 'pets/:id', to: 'pets#show'
# get 'pets/new', to: 'pets#new'
# post 'pets/new', to: 'pets#create'
end
