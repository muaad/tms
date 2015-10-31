json.array!(@trucks) do |truck|
  json.extract! truck, :id, :registration_number
  json.url truck_url(truck, format: :json)
end
