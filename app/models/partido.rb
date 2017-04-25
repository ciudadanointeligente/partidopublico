# == Schema Information
#
# Table name: partidos
#
#  id                      :integer          not null, primary key
#  nombre                  :string           not null
#  sigla                   :string
#  lema                    :string
#  fecha_fundacion         :date
#  texto                   :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  logo_file_name          :string
#  logo_content_type       :string
#  logo_file_size          :integer
#  logo_updated_at         :datetime
#  front_logo_file_name    :string
#  front_logo_content_type :string
#  front_logo_file_size    :integer
#  front_logo_updated_at   :datetime
#  cplt_code               :string
#  url                     :string
#

class Partido < ActiveRecord::Base
    has_paper_trail
    has_attached_file :logo, styles: { large: "600x600>", medium: "300x300>", thumb: "220x110>" }, default_url: "/resources/missing.png"
    validates_attachment :logo,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    has_attached_file :front_logo, styles: { large: "600x600>", medium: "300x300>", thumb: "220x110>" }, default_url: "/resources/missing.png"
    validates_attachment :front_logo,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :message => "debe rellenar"
    validates_uniqueness_of :nombre, :message => "already exists"

    has_many :admins, {:through=>:permissions, :source=>"admin"}

    has_many :permissions, dependent: :destroy

    has_one :marco_general, dependent: :destroy
    has_one :marco_interno, dependent: :destroy
    has_many :organo_internos, dependent: :destroy
    has_and_belongs_to_many :regions
    has_many :sedes, dependent: :destroy
    has_many :afiliacions, dependent: :destroy
    has_many :tramites, dependent: :destroy
    has_many :eleccion_populars, dependent: :destroy
    has_many :eleccion_internas, dependent: :destroy
    has_many :actividad_publicas, dependent: :destroy
    has_many :acuerdos, dependent: :destroy
    has_many :participacion_entidads, dependent: :destroy
    has_and_belongs_to_many :pacto_electorals, :uniq => true
    has_many :sancions, dependent: :destroy
    has_many :personas, dependent: :destroy
    has_many :cargos, dependent: :destroy
    has_many :tipo_cargos, dependent: :destroy
    has_many :ingreso_ordinarios, dependent: :destroy
    has_many :egreso_ordinarios, dependent: :destroy
    has_many :balance_anuals, dependent: :destroy
    has_many :contratacions, dependent: :destroy
    has_many :transferencias, dependent: :destroy
    has_many :ingreso_campanas, dependent: :destroy
    has_many :egreso_campanas, dependent: :destroy

    accepts_nested_attributes_for :marco_interno, allow_destroy: true
    accepts_nested_attributes_for :organo_internos, allow_destroy: true
    accepts_nested_attributes_for :sedes, reject_if: proc { |attributes| attributes['direccion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :afiliacions, allow_destroy: true
    accepts_nested_attributes_for :tramites, allow_destroy: true
    accepts_nested_attributes_for :eleccion_populars, allow_destroy: true
    accepts_nested_attributes_for :eleccion_internas, allow_destroy: true
    accepts_nested_attributes_for :actividad_publicas, allow_destroy: true
    accepts_nested_attributes_for :acuerdos, allow_destroy: true
    accepts_nested_attributes_for :participacion_entidads, allow_destroy: true
    accepts_nested_attributes_for :pacto_electorals, allow_destroy: true
    accepts_nested_attributes_for :sancions, allow_destroy: true

    after_create :initialize_transparency_settings

    #scope :representantes, -> { cargos.where(tipo_cargo.representante: true) }

    def representantes
      cargos = Cargo.where partido: self.id
      representantes = []
      cargos.each do |c|
        if c.tipo_cargo.representante
          representantes << c
        end
      end
      return representantes
    end

    def autoridades
      cargos = Cargo.where partido: self.id
      autoridades = []
      cargos.each do |c|
        if c.tipo_cargo.autoridad
          autoridades << c
        end
      end
      return autoridades
    end

    def cargos_internos
      cargos = Cargo.where partido: self.id
      cargos_internos = []
      cargos.each do |c|
        if c.tipo_cargo.cargo_interno
          cargos_internos << c
        end
      end
      return cargos_internos
    end

    def candidatos
      cargos = Cargo.where partido: self.id
      candidatos = []
      cargos.each do |c|
        if c.tipo_cargo.candidato
          candidatos << c
        end
      end
      return candidatos
    end

    def initialize_transparency_settings

      superadmins = Admin.where is_superadmin: true
      superadmins.each do |admin|
        self.admins << admin
      end

      #self.marco_general = MarcoGeneral.new
      # self.marco_interno = MarcoInterno.new
      # # self.marco_interno.documentos << Documento.new(descripcion:"Marco Normativo Interno", obligatorio: true)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Código de Ética", obligatorio: false)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Procedimiento de Prevención de la Corrupción", obligatorio: false)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Reseña Histórica", obligatorio: false)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Declaración de Principios", obligatorio: true)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Programa Base", obligatorio: false)
      # # self.marco_interno.documentos << Documento.new(descripcion:"Estructura Orgánica", obligatorio: true)
      # self.marco_interno.documentos << Documento.new(descripcion:"Estatutos del partido", obligatorio: true)
      # self.marco_interno.documentos << Documento.new(descripcion:"Declaración de principios", obligatorio: true)
      # self.marco_interno.documentos << Documento.new(descripcion:"Reglamiento interno", obligatorio: true)
      #
      # self.organo_internos << OrganoInterno.new(nombre:"Órgano ejecutivo")
      # self.organo_internos << OrganoInterno.new(nombre:"Órgano intermedio colegiado")
      # self.organo_internos << OrganoInterno.new(nombre:"Tribunal supremo")
      # self.tramites << Tramite.new(nombre:"Afiliación")
      # self.tramites << Tramite.new(nombre:"Desfiliación")
      # self.personas << Persona.new( rut:"14132725-"+self.id.to_s,
      #                               nombre:"Ejemplo",
      #                               apellidos:"Ejemplo Ejemplo",
      #                               genero:"Otro",
      #                               telefono:"+56912345678",
      #                               email:"ejemplo@ejemplo.com",
      #                               intereses:"http://www.servel.cl/intereses",
      #                               patrimonio:"http://www.servel.cl/patrimonio",
      #                               fecha_nacimiento:Date.new(1900, 01, 01),
      #                               nivel_estudios:"Ejemplo",
      #                               afiliado:true,
      #                               ano_inicio_militancia:"1950",
      #                               bio:"Ejemplo Biografía"
      #                               )
      # self.tipo_cargos << TipoCargo.new(titulo:"Alcalde", representante: true)
      # self.tipo_cargos << TipoCargo.new(titulo:"Concejal", representante: true)
      # self.tipo_cargos << TipoCargo.new(titulo:"Senador", representante: true)
      # self.tipo_cargos << TipoCargo.new(titulo:"Diputado", representante: true)
      # self.tipo_cargos << TipoCargo.new(titulo:"Presidente", representante: true)
      # self.tipo_cargos << TipoCargo.new(titulo:"Consejero Regional", representante: true)
      #
      # self.save
    end

    def to_s
        self.sigla
    end

    def completed_percentage
      total = 0

      if self.nombre
        total = total + 2
      end
      if self.sigla
        total = total + 2
      end
      if self.lema
        total = total + 2
      end
      if self.fecha_fundacion
        total = total + 2
      end

      if self.personas.any?
        total = total + 2
      end
      if self.cargos.any?
        total = total + 2
      end
      if self.sedes.any?
        total = total + 2
      end
      if self.regions.any?
        total = total + 2
      end
      if self.organo_internos.any?
        total = total + 2
      end
      if self.afiliacions.any?
        total = total + 2
      end
    end

    def afiliados
      last_date = Afiliacion.where(partido_id: self).uniq.pluck(:fecha_datos).sort.last
      datos_afiliacion = Afiliacion.where(partido_id: self, fecha_datos: last_date)

      num_afiliados = datos_afiliacion.to_a.sum(&:total)
    end
end
