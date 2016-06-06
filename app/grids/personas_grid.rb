class PersonasGrid

  include Datagrid

  scope do
    #puts request
    Persona
  end

  #filter(:id, :integer)
  #filter(:tipo, :enum, :select => Persona.tipos.map {|r| [r.humanize, r]})
  filter(:rut, :string)
  filter(:nombre, :string)
  filter(:apellidos, :string)
  # filter(:region, :enum, :select => Region.all.order(:nombre).map {|r| [r.nombre, r.id]})
  # filter(:comuna, :enum, :select => Comuna.all.order(:nombre).map {|r| [r.nombre, r.id]})
  # filter(:circunscripcion, :enum, :select => Circunscripcion.all.order(:nombre).map {|r| [r.nombre, r.id]})
  # filter(:distrito, :enum, :select => Distrito.all.map {|r| [r.nombre, r.id]})

  #filter(:condition, :dynamic, :header => "Condición")
  #column_names_filter(:header => "&nbsp", checkboxes: true)

  #filter(:created_at, :date, :range => true)
  column(:actions, :html => true, :mandatory => true) do |record|
    link_to "Editar", "#", 'ng-click' => 'getPersonaModal('+record.id.to_s+')'
  end
#column(:id)
  column(:genero, :mandatory => true)
  column(:rut, :mandatory => true)
  column(:nombre, :mandatory => true)
  column(:apellidos, :mandatory => true)
  column(:telefono, :mandatory => false)
  column(:email, :mandatory => true)
  column(:intereses, :mandatory => false)
  column(:patrimonio, :mandatory => false)

  column(:fecha_nacimiento, :mandatory => false)
  column(:nivel_estudios, :mandatory => false)
  column(:afiliado, :mandatory => false) do
    afiliado? ? "Si" : "No"
  end
  column(:ano_inicio_militancia, :mandatory => false)
  column(:bio, :mandatory => false)


  # column(:region) do |record|
  #   record.region.present? ? Region.find(record.region) : ""
  # end
  # column(:comuna) do |record|
  #   record.comuna.present? ? Comuna.find(record.comuna) : ""
  # end
  # column(:circunscripcion) do |record|
  #   record.circunscripcion.present? ? Circunscripcion.find(record.circunscripcion) : ""
  # end
  # column(:distrito) do |record|
  #   record.distrito.present? ? Distrito.find(record.distrito) : ""
  # end
  # column(:fecha_desde)
  # column(:fecha_hasta)
  #
  #
  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end
  # column(:updated_at) do |model|
  #   model.updated_at.to_date
  # end
end
