# == Schema Information
#
# Table name: partidos
#
#  id                :integer          not null, primary key
#  nombre            :string           not null
#  sigla             :string           not null
#  lema              :string           not null
#  fecha_fundacion   :date
#  texto             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

class Partido < ActiveRecord::Base
    has_paper_trail
    has_attached_file :logo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :logo,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :sigla, :lema, :message => "debe rellenar"
    validates_uniqueness_of :nombre, :sigla, :lema, :message => "already exists"
    validates_length_of :lema, :within => 2..200
    

    has_one :marco_general, dependent: :destroy
    has_one :marco_interno, dependent: :destroy
    has_many :organo_internos, dependent: :destroy
    has_and_belongs_to_many :regions
    has_many :sedes, dependent: :destroy
    has_many :afiliacions, dependent: :destroy
    has_many :tramites, dependent: :destroy
    # has_many :personas, as: :personable
    # delegate :representantes, :meerkats, :wild_boars, to: :personas
    has_many :representantes, as: :personable, dependent: :destroy
    has_many :autoridads, as: :personable, dependent: :destroy
    has_many :eleccion_populars, dependent: :destroy
    has_many :eleccion_internas, dependent: :destroy
    
    
    accepts_nested_attributes_for :marco_interno, allow_destroy: true
    accepts_nested_attributes_for :organo_internos, allow_destroy: true
    accepts_nested_attributes_for :sedes, reject_if: proc { |attributes| attributes['direccion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :afiliacions, allow_destroy: true
    accepts_nested_attributes_for :tramites, allow_destroy: true
    # accepts_nested_attributes_for :personas, allow_destroy: true
    accepts_nested_attributes_for :representantes, allow_destroy: true
    accepts_nested_attributes_for :autoridads, allow_destroy: true
    accepts_nested_attributes_for :eleccion_populars, allow_destroy: true
    accepts_nested_attributes_for :eleccion_internas, allow_destroy: true
    
    after_create :initialize_transparency_settings
    
    def initialize_transparency_settings
       self.marco_general = MarcoGeneral.new
       self.marco_interno = MarcoInterno.new
       self.marco_interno.documentos << Documento.new(descripcion:"Marco Normativo Interno")
       self.marco_interno.documentos << Documento.new(descripcion:"Código de Ética")
       self.marco_interno.documentos << Documento.new(descripcion:"Procedimiento de Prevención de la Corrupción")
       self.marco_interno.documentos << Documento.new(descripcion:"Reseña Histórica")
       self.marco_interno.documentos << Documento.new(descripcion:"Declaración de Principios")
       self.marco_interno.documentos << Documento.new(descripcion:"Programa Base")
       self.marco_interno.documentos << Documento.new(descripcion:"Estructura Orgánica")
       self.organo_internos << OrganoInterno.new(nombre:"Órgano ejecutivo")
       self.organo_internos << OrganoInterno.new(nombre:"Órgano intermedio colegiado")
       self.organo_internos << OrganoInterno.new(nombre:"Tribunal supremo")
       self.tramites << Tramite.new(nombre:"Afiliación")
       self.tramites << Tramite.new(nombre:"Desfiliación")
       self.save
    end
    
    def to_s
        self.sigla
    end
    
end
