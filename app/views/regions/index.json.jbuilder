json.array!(@regions) do |region|
  json.extract! region, :id, :nombre
end
