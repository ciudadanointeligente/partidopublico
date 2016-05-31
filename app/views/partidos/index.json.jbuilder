json.array!(@partidos) do |partido|
  json.extract! partido, :id, :nombre, :sigla
  json.url partido_url(partido, format: :json)
end
