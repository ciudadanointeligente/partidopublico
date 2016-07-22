json.array!(@comunas) do |comuna|
  json.extract! comuna, :id, :nombre, :provincia_id
end
