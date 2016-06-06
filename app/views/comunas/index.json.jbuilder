json.array!(@comunas) do |comuna|
  json.merge! comuna.attributes
end
