json.array!(@status_requests) do |status_request|
  json.extract! status_request, :id, :nombre
  json.url status_request_url(status_request, format: :json)
end
