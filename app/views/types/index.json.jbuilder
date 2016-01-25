json.array!(@types) do |type|
  json.extract! type, :id, :nombre, :descripcion, :slug
  json.url type_url(type, format: :json)
end
