json.array!(@hires) do |hire|
  json.extract! hire, :id, :book, :child
  json.url hire_url(hire, format: :json)
end
