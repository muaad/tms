json.array!(@cashes) do |cash|
  json.extract! cash, :id, :date, :amount_in, :amount_out, :balance, :closed
  json.url cash_url(cash, format: :json)
end
