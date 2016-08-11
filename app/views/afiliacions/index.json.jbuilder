json.array!(@afiliacions) do |afiliacion|
  json.extract! afiliacion, :id, :region, :hombres, :mujeres, :otros, :ano_nacimiento, :fecha_datos
end
