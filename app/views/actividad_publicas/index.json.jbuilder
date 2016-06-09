json.array!(@actividad_publicas) do |actividad_publica|
  json.extract! actividad_publica, :id
  json.url actividad_publica_url(actividad_publica, format: :json)
end
