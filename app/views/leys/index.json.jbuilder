json.array!(@leys) do |ley|
  json.extract! ley, :id, :numero, :nombre, :enlace, :tags, :resumen, :marco_general_id
  json.url ley_url(ley, format: :json)
end
