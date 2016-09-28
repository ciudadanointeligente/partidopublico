json.array!(@circunscripcions) do |circunscripcion|
  json.extract! circunscripcion, :id, :nombre
end
