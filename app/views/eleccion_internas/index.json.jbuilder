json.array!(@eleccion_internas) do |eleccion_interna|
  json.extract! eleccion_interna, :id, :organo_interno_id, :fecha_eleccion, :fecha_limite_inscripcion, :cargo
  json.url eleccion_interna_url(eleccion_interna, format: :json)
end
