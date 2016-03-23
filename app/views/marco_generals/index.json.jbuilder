json.array!(@marco_generals) do |marco_general|
  json.extract! marco_general, :id, :partido_id
  json.url marco_general_url(marco_general, format: :json)
end
