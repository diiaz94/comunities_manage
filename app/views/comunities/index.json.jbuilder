json.array!(@comunities) do |comunity|
  json.extract! comunity, :id, :nombre, :direccion, :slug
  json.url comunity_url(comunity, format: :json)
end
