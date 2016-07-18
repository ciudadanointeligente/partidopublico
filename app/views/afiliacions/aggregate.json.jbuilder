json.array!(@datos) do |dato|
  json.extract! dato, :fecha_datos,  :count_regiones , :total_afiliados

end
