json.array!(@partidos) do |partido|
  json.extract! partido, :id
  json.url partido_url(partido, format: :json)
end
