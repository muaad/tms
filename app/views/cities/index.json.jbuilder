json.array!(@cities) do |city|
  json.extract! city, :id, :name, :country, :city_type
  json.url city_url(city, format: :json)
end
