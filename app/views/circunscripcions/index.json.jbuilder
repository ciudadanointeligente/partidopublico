json.array!(@circunscripcions) do |circunscripcion|
  json.extract! circunscripcion, :id
  json.url circunscripcion_url(circunscripcion, format: :json)
end
