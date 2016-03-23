json.array!(@procedimientos) do |procedimiento|
  json.extract! procedimiento, :id, :descripcion
  json.url procedimiento_url(procedimiento, format: :json)
end
