json.array!(@sedes) do |sede|
  json.extract! sede, :id, :region, :direccion, :contacto
  json.url sede_url(sede, format: :json)
end
