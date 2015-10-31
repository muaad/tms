json.array!(@diesel_companies) do |diesel_company|
  json.extract! diesel_company, :id, :name, :price
  json.url diesel_company_url(diesel_company, format: :json)
end
