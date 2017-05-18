json.array!(@genres) do |genre|
  json.extract! genre, :id, :Name
  json.url genre_url(genre, format: :json)
end
