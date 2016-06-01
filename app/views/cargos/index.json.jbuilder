json.array!(@cargos) do |cargo|
  json.extract! cargo, :id, :persona_id, :cargo_id, :partido_id
  json.url cargo_url(cargo, format: :json)
end
