json.array!(@expense_categories) do |expense_category|
  json.extract! expense_category, :id, :name
  json.url expense_category_url(expense_category, format: :json)
end
