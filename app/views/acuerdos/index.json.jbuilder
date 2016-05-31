json.array!(@acuerdos) do |acuerdo|
  json.extract! acuerdo, :id, :numero, :fecha, :tipo, :tema, :region, :organo_interno_id
  json.url acuerdo_url(acuerdo, format: :json)
end
