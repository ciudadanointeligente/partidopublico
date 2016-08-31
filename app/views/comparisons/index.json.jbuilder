json.array!(@comparisons) do |comparison|
  json.extract! comparison, :id
  json.url comparison_url(comparison, format: :json)
end
