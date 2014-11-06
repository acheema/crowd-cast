json.array!(@advertisements) do |advertisement|
  json.extract! advertisement, :id, :title, :description, :screen_resolution_x, :screen_resolution_y, :advertiser_id, :advertisement_url
  json.url advertisement_url(advertisement, format: :json)
end
