json.array!(@transferencias) do |transferencia|
  json.extract! transferencia, :id, :partido_id, :fecha_datos, :numero, :razon_social, :rut, :region_id, :descripcion, :monto, :categoria, :fecha
  json.url transferencia_url(transferencia, format: :json)
end
