json.array!(@datos) do |dato|
  json.extract! dato, :fecha_datos,  :count , :total_activo, :total_pasivo

end
