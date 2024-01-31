Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # root to: "pages#home"
  # Justine: Adding list of pets as root page
  root to: "pets#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :pets do
    resources :bookings, except: [:destroy]
  end
  resources :bookings, only: [:destroy, :update]
  resources :pages
end
