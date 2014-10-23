json.array!(@advertisers) do |advertiser|
  json.extract! advertiser, :id, :username, :password_salt, :password_hash, :email, :company, :usertype
  json.url advertiser_url(advertiser, format: :json)
end
