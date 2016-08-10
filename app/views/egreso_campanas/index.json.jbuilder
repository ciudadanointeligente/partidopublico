json.array!(@egreso_campanas) do |egreso_campana|
  json.extract! egreso_campana, :id, :partido_id, :fecha_datos, :fecha_eleccion, :rut_candidato, :rut_proveedor, :nombre, :proveedor, :fecha_documento, :tipo_documento, :numero_documento, :numero_cuenta, :p_o_c, :glosa, :monto
  json.url egreso_campana_url(egreso_campana, format: :json)
end
