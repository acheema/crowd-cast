json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :listing_id, :advertiser_id, :advertisement_id, :start_date, :end_date, :price
  json.url reservation_url(reservation, format: :json)
end
