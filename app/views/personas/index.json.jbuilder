json.array!(@personas) do |persona|
  #json.extract! persona, :id, :genero, :fecha_nacimiento, :nivel_estudios, :region, :ano_inicio_militancia, :afiliado, :bio, :nombre, :apellidos, :rut
  #json.url persona_url(persona, format: :json)
  json.merge! persona.attributes
end
