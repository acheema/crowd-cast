json.array!(@messages) do |message|
  json.extract! message, :id, :listing_id, :to_username, :from_username, :message, :type, :viewed
  json.url message_url(message, format: :json)
end
