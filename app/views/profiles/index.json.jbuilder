json.array!(@profiles) do |profile|
  json.extract! profile, :id, :cedula, :nombres, :apellidos, :email, :telefono, :fecha_nac, :slug
  json.url profile_url(profile, format: :json)
end
