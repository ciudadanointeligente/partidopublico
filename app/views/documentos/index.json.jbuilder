json.array!(@documentos) do |documento|
  json.extract! documento, :id, :descripcion
  json.url documento_url(documento, format: :json)
end
