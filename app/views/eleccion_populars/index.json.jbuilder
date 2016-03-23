json.array!(@eleccion_populars) do |eleccion_popular|
  json.extract! eleccion_popular, :id, :fecha_eleccion, :dias, :cargo
  json.url eleccion_popular_url(eleccion_popular, format: :json)
end
