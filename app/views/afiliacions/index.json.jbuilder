json.array!(@afiliacions) do |afiliacion|
  json.extract! afiliacion, :id, :region_id, :hombres, :mujeres, :rangos
  json.url afiliacion_url(afiliacion, format: :json)
end
