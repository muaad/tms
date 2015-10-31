json.array!(@truck_owners) do |truck_owner|
  json.extract! truck_owner, :id, :name, :phone_number, :address, :id_number, :entity_type
  json.url truck_owner_url(truck_owner, format: :json)
end
