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
#  user_id           :integer
#
# Indexes
#
#  index_partidos_on_user_id  (user_id)
#

class Partido < ActiveRecord::Base
    has_paper_trail
    has_attached_file :logo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :logo,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :sigla, :lema, :message => "debe rellenar"
    validates_uniqueness_of :nombre, :sigla, :lema, :user, :message => "already exists"
    validates_uniqueness_of :user, :message => "already has a party"
    validates_length_of :lema, :within => 2..200
    
    belongs_to :user
    has_one :marco_general, dependent: :destroy
    has_one :marco_interno, dependent: :destroy
    has_many :organo_internos, dependent: :destroy
    has_and_belongs_to_many :regions
    has_many :sedes
    has_many :afiliacions
    
    accepts_nested_attributes_for :marco_interno, allow_destroy: true
    accepts_nested_attributes_for :sedes, reject_if: proc { |attributes| attributes['direccion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :afiliacions, allow_destroy: true
    
    
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
       self.save
    end
    
    def to_s
        self.sigla
    end
    
end
