json.array!(@sedes) do |sede|
  json.extract! sede, :id, :region, :direccion, :contacto, :comuna
  json.url sede_url(sede, format: :json)
end
