json.array!(@owners) do |owner|
  json.extract! owner, :id, :username, :password_salt, :password_hash, :email, :company, :usertype
  json.url owner_url(owner, format: :json)
end
