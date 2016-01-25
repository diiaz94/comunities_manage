json.array!(@towns) do |town|
  json.extract! town, :id, :nombre
  json.url town_url(town, format: :json)
end
