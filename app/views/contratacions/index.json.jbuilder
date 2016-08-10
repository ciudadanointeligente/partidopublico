json.array!(@contratacions) do |contratacion|
  json.extract! contratacion, :id, :partido_id, :fecha_datos, :numero, :individualizacion, :razon_social, :rut, :titulares, :descripcion, :monto, :fecha_inicio, :fecha_termino, :link
  json.url contratacion_url(contratacion, format: :json)
end
