json.array!(@datos) do |dato|
  json.extract! dato, :fecha_datos, :fecha_eleccion, :count , :total

end
