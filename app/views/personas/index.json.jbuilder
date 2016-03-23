json.array!(@personas) do |persona|
  json.extract! persona, :id, :genero, :fecha_nacimiento, :nivel_estudios, :region, :ano_inicio_militancia, :afiliado, :bio
  json.url persona_url(persona, format: :json)
end
