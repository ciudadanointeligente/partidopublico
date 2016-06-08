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
#  rut                   :string
#
# Indexes
#
#  index_personas_on_partido_id                         (partido_id)
#  index_personas_on_personable_type_and_personable_id  (personable_type,personable_id)
#

class Persona < ActiveRecord::Base
    require 'csv'

    has_paper_trail
    has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/resources/missing.png"
    validates_attachment :foto,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :apellidos, :partido_id, :message => "debe rellenar"
    validates_uniqueness_of :rut

    belongs_to :partido
    belongs_to :personable, polymorphic: true
    self.inheritance_column = :tipo

    has_many :cargos
    has_many :tipo_cargos, through: :cargos

    scope :representantes, -> { where(tipo: 'Representante') }
    scope :autoridades, -> { where(tipo: 'Autoridad') }

    def self.tipos
      %w(Representante Autoridad Candidato Responsable Cargo)
    end

    # a class method import, with file passed through as an argument
    def self.import(file, partido_id)
      partido = Partido.find partido_id
      # a block that runs through a loop in our CSV data
      CSV.foreach(file.path, headers: true) do |row|
        # creates a user for each row in the CSV file
        new_row = {}

        #h.keys.each { |k| h[k[1, k.length - 1]] = h[k]; h.delete(k) }
        row.to_hash.each {|key,value| row[key.parameterize.underscore] = value ; row.delete(key)}
        puts row.to_hash
        puts new_row

        u = Persona.find_by_rut row.to_hash['rut']
        if u.blank?
          puts "persona nuevaaaaaaaaaaaaaaaa"
          u = Persona.new row.to_hash
          u.partido = partido
        else
          puts "persona actualizadaaaaaaaaaaaaaaa"
          u.update_attributes(row.to_hash)
          u.partido = partido
        end
        u.save
      end
    end

    def self.to_csv
      attributes = %w{rut nombre apellidos genero telefono email intereses patrimonio fecha_nacimiento nivel_estudios afiliado ano_inicio_militancia bio}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |persona|
          csv << attributes.map{|attr| persona.send(attr)}
        end
      end
    end

    def to_s
      self.nombre + " " + self.apellidos + " " + self.rut
    end
end
