json.array!(@datos) do |dato|
  json.extract! dato, :fecha_datos,  :count , :total_publico, :total_privado

end
