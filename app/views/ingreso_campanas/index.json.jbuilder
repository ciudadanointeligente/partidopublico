json.array!(@ingreso_campanas) do |ingreso_campana|
  json.extract! ingreso_campana, :id, :partido_id, :fecha_datos, :fecha_eleccion, :rut_candidato, :rut_donante, :nombre_donante, :fecha_documento, :tipo_documento, :numero_documento, :numero_cuenta, :glosa, :monto
  json.url ingreso_campana_url(ingreso_campana, format: :json)
end
