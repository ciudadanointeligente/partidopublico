# == Schema Information
#
# Table name: personas
#
#  id                    :integer          not null, primary key
#  genero                :string
#  fecha_nacimiento      :date
#  nivel_estudios        :string
#  region                :string
#  ano_inicio_militancia :integer
#  afiliado              :boolean
#  bio                   :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  foto_file_name        :string
#  foto_content_type     :string
#  foto_file_size        :integer
#  foto_updated_at       :datetime
#  nombre                :string
#  apellidos             :string
#  partido_id            :integer
#  personable_id         :integer
#  personable_type       :string
#  cargo                 :string
#  distrito              :string
#  circunscripcion       :string
#  comuna                :string
#  telefono              :string
#  email                 :string
#  fecha_desde           :date
#  fecha_hasta           :date
#  tipo                  :string
#  intereses             :string
#  patrimonio            :string
#
# Indexes
#
#  index_personas_on_partido_id                         (partido_id)
#  index_personas_on_personable_type_and_personable_id  (personable_type,personable_id)
#

class Persona < ActiveRecord::Base
    has_paper_trail
    has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/resources/missing.png"
    validates_attachment :foto,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :apellidos, :message => "debe rellenar"
    
    belongs_to :partido
    belongs_to :personable, polymorphic: true
    self.inheritance_column = :tipo
 
    scope :representantes, -> { where(tipo: 'Representante') } 
    scope :autoridades, -> { where(race: 'Autoridad') } 
    scope :cargos, -> { where(race: 'Cargo') }
 
    def self.tipos
      %w(Representante Autoridad Cargo)
    end
end
