json.array!(@cargos) do |cargo|
  json.extract! cargo, :id, :persona_id, :persona, :tipo_cargo_id, :tipo_cargo, :partido_id, :fecha_desde, :fecha_hasta, :lugar
  json.url cargo_url(cargo, format: :json)
end
