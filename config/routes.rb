Rails.application.routes.draw do
  get '/dashboard' => "dashboard#index", as: "dashboard"

  resources :diesel_companies
  resources :expenses
  resources :products
  resources :trucks
  resources :turn_boys
  resources :drivers
  resources :truck_owners
  resources :expense_categories
  resources :accounts
  root to: 'home#index'
  devise_for :users

  post "/trucks/delete_multiple" => "trucks#delete_multiple", as: "delete_multiple_trucks"
  post "/turn_boys/delete_multiple" => "turn_boys#delete_multiple", as: "delete_multiple_turn_boys"
  post "/truck_owners/delete_multiple" => "truck_owners#delete_multiple", as: "delete_multiple_truck_owners"
  post "/products/delete_multiple" => "products#delete_multiple", as: "delete_multiple_products"
  post "/expenses/delete_multiple" => "expenses#delete_multiple", as: "delete_multiple_expenses"
  post "/expense_categories/delete_multiple" => "expense_categories#delete_multiple", as: "delete_multiple_expense_categories"
  post "/drivers/delete_multiple" => "drivers#delete_multiple", as: "delete_multiple_drivers"
  post "/diesel_companies/delete_multiple" => "diesel_companies#delete_multiple", as: "delete_multiple_diesel_companies"
end
