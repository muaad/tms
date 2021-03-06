Rails.application.routes.draw do
  resources :notifications do
    collection { get :events }
  end
  resources :exchange_rates
  get 'reports/accounts'

  get 'reports/trucks'

  get 'reports/trips'

  get 'reports/drivers'

  get 'reports/turn_boys'

  get 'reports/owners'

  get 'reports/cash'

  get '/reports/accounts/:category' => "reports#category", as: "reports_category"

  get '/dashboard' => "dashboard#index", as: "dashboard"
  get '/diesel_expenses/new' => "expenses#new_diesel_expense", as: "new_diesel_expense"
  get '/diesel_expenses/:id/edit' => "expenses#edit_diesel_expense", as: "edit_diesel_expense"
  get '/diesel_expenses' => "expenses#diesel_expenses", as: "diesel_expenses"
  get '/trips/diesel_expense' => "trips#diesel_expense"

  root to: 'home#index'

  post "/trucks/delete_multiple" => "trucks#delete_multiple", as: "delete_multiple_trucks"
  post "/consignees/delete_multiple" => "consignees#delete_multiple", as: "delete_multiple_consignees"
  post "/cities/delete_multiple" => "cities#delete_multiple", as: "delete_multiple_cities"
  post "/trips/delete_multiple" => "trips#delete_multiple", as: "delete_multiple_trips"
  post "/turn_boys/delete_multiple" => "turn_boys#delete_multiple", as: "delete_multiple_turn_boys"
  post "/truck_owners/delete_multiple" => "truck_owners#delete_multiple", as: "delete_multiple_truck_owners"
  post "/products/delete_multiple" => "products#delete_multiple", as: "delete_multiple_products"
  post "/expenses/delete_multiple" => "expenses#delete_multiple", as: "delete_multiple_expenses"
  post "/expense_categories/delete_multiple" => "expense_categories#delete_multiple", as: "delete_multiple_expense_categories"
  post "/drivers/delete_multiple" => "drivers#delete_multiple", as: "delete_multiple_drivers"
  post "/diesel_companies/delete_multiple" => "diesel_companies#delete_multiple", as: "delete_multiple_diesel_companies"
  post "/users/delete_multiple" => "users#delete_multiple", as: "delete_multiple_users"

  post "/expenses/inline_create" => "expenses#inline_create", as: "inline_create_expenses"

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users, except: [:delete]
  resources :diesel_companies, :attachments, :expenses, :products, :trucks, :turn_boys, :drivers, :truck_owners, :expense_categories, :accounts, :truck_cashes, :cashes, :trips, :consignees, :cities
end
