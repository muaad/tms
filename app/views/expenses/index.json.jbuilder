json.array!(@expenses) do |expense|
  json.extract! expense, :id, :expense_category_id, :amount, :product_id, :driver_id, :truck_id, :turn_boy_id, :user_id, :description, :lpo
  json.url expense_url(expense, format: :json)
end
