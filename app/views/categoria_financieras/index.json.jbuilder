json.array!(@categorias_financieras) do |cat|
  json.extract! cat, :id, :documento_id, :titulo, :fecha
end