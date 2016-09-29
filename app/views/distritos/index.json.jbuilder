json.array!(@distritos) do |distrito|
  json.extract! distrito, :id, :nombre
  json.url distrito_url(distrito, format: :json)
end
