json.array!(@drivers) do |driver|
  json.extract! driver, :id, :name, :phone_number, :address, :id_number
  json.url driver_url(driver, format: :json)
end
