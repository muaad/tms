json.array!(@notifications) do |notification|
  json.extract! notification, :id, :attachment_id, :notification_type, :read, :resolved, :attachment_name
  json.url notification_url(notification, format: :json)
end
