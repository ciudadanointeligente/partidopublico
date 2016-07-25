json.array!(@ingreso_ordinarios) do |ingreso_ordinario|
  json.extract! ingreso_ordinario, :id
  json.url ingreso_ordinario_url(ingreso_ordinario, format: :json)
end
