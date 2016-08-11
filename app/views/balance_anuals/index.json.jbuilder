json.array!(@balance_anuals) do |balance_anual|
  json.extract! balance_anual, :id, :partido_id, :fecha_datos, :concepto, :tipo, :importe
  json.url balance_anual_url(balance_anual, format: :json)
end
