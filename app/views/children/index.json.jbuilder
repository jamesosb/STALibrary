json.array!(@children) do |child|
  json.extract! child, :id, :nickname, :forename, :surname, :UPN, :Class
  json.url child_url(child, format: :json)
end
