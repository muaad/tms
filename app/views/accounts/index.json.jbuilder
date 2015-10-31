json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :email, :phone_number, :active
  json.url account_url(account, format: :json)
end
