json.array!(@distritos) do |distrito|
  json.extract! distrito, :id
  json.url distrito_url(distrito, format: :json)
end
