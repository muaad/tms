json.array!(@truck_cashes) do |truck_cash|
  json.extract! truck_cash, :id, :truck_id, :amount, :date, :lpo, :description
  json.url truck_cash_url(truck_cash, format: :json)
end
