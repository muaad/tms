Rails.application.routes.draw do
  resources :expense_categories
  resources :accounts
  root to: 'visitors#index'
  devise_for :users
end
