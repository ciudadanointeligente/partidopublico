json.array!(@tipo_cargos) do |tipo_cargo|
  json.extract! tipo_cargo, :id, :titulo, :created_at
  json.url tipo_cargo_url(tipo_cargo, format: :json)
end
