json.array!(@tramites) do |tramite|
  json.extract! tramite, :id, :nombre, :descripcion, :persona_id
  json.url tramite_url(tramite, format: :json)
end
