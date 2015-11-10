json.array!(@trucks) do |truck|
  json.extract! truck, :id, :registration_number, :trips
  json.url truck_url(truck, format: :json)
end
