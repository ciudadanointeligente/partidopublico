json.array!(@organo_internos) do |organo_interno|
  json.extract! organo_interno, :id, :nombre, :funciones
  json.url organo_interno_url(organo_interno, format: :json)
end
