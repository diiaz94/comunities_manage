json.array!(@type_requests) do |type_request|
  json.extract! type_request, :id, :nombre, :formato
  json.url type_request_url(type_request, format: :json)
end
