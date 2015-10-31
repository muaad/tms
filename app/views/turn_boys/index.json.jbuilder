json.array!(@turn_boys) do |turn_boy|
  json.extract! turn_boy, :id, :name, :phone_number, :address, :id_number
  json.url turn_boy_url(turn_boy, format: :json)
end
