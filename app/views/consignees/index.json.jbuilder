json.array!(@consignees) do |consignee|
  json.extract! consignee, :id, :name, :phone_number, :city_id
  json.url consignee_url(consignee, format: :json)
end
