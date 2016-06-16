json.array!(@actividad_publicas) do |actividad_publica|
  json.merge! actividad_publica.attributes
end
