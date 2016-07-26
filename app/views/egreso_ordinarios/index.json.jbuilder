json.array!(@egreso_ordinarios) do |egreso_ordinario|
  json.extract! egreso_ordinario, :id, :partido_id, :fecha_datos, :concepto, :privado, :publico
  json.url egreso_ordinario_url(egreso_ordinario, format: :json)
end
