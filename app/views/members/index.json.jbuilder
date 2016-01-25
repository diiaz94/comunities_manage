json.array!(@members) do |member|
  json.extract! member, :id, :rol, :descripcion
  json.url member_url(member, format: :json)
end
