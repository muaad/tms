Rails.application.routes.draw do
  resources :drivers
  resources :truck_owners
  resources :expense_categories
  resources :accounts
  root to: 'visitors#index'
  devise_for :users
end
