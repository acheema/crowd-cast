json.array!(@listings) do |listing|
  json.extract! listing, :id, :title, :height, :width, :time_per_click, :views_per_week, :cost_per_week, :street, :city, :state, :zip, :latitude, :longitude
  json.url listing_url(listing, format: :json)
end
