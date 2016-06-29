json.array!(@item_contables) do |item|
  json.extract! item, :id, :concepto, :dinero_publico, :importe, :categoria_financiera_id
  json.categoria_financiera item.categoria_financiera.titulo
end