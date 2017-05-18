json.array!(@books) do |book|
  json.extract! book, :id, :Title, :Genre, :ISBN
  json.url book_url(book, format: :json)
end
