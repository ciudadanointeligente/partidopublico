json.array!(@marco_internos) do |marco_interno|
  json.extract! marco_interno, :id, :partido_id
  json.url marco_interno_url(marco_interno, format: :json)
end
