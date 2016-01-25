json.array!(@families) do |family|
  json.extract! family, :id, :nombre_casa, :numero_casa, :telefono, :slug
  json.url family_url(family, format: :json)
end
