json.array!(@parishes) do |parish|
  json.extract! parish, :id, :nombre
  json.url parish_url(parish, format: :json)
end
