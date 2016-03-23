json.array!(@requisitos) do |requisito|
  json.extract! requisito, :id, :descripcion
  json.url requisito_url(requisito, format: :json)
end
