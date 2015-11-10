json.array!(@trips) do |trip|
  json.extract! trip, :id, :truck_id, :driver_id, :turn_boy_id, :date, :depot_id, :destination_id, :consignee_id, :product_id, :quantity, :rate, :amount, :commission, :short, :description, :currency, :name
  json.url trip_url(trip, format: :json)
end
