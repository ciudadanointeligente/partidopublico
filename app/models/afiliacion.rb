# == Schema Information
#
# Table name: afiliacions
#
#  id             :integer          not null, primary key
#  hombres        :integer
#  mujeres        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  partido_id     :integer
#  region_id      :integer
#  fecha_datos    :date
#  ano_nacimiento :integer
#  otros          :integer
#
# Indexes
#
#  index_afiliacions_on_partido_id  (partido_id)
#  index_afiliacions_on_region_id   (region_id)
#

class Afiliacion < ActiveRecord::Base
  has_paper_trail
  belongs_to :partido
  belongs_to :region

  # validates_presence_of :partido_id, :fecha_datos, :region_id, :ano_nacimiento
  validates_presence_of :partido_id

  before_save :default_afiliados
  # before_save :corregir_fecha

  def default_afiliados
     self.hombres ||= 0
     self.mujeres ||= 0
     self.otros ||= 0
  end

  def total
     self.hombres + self.mujeres + self.otros
  end

  # def corregir_fecha
  #   year = self.fecha_datos.strftime("%Y")
  #   month = self.fecha_datos.strftime("%m")
  #   self.fecha_datos = Date.new(year.to_i, month.to_i, 01)
  # end

  # a class method import, with file passed through as an argument
  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        new_row_hash = row.to_hash

        region = Region.find_by_ordinal new_row_hash['region']
        new_row_hash['region_id'] = region.id
        new_row_hash.delete('region')
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')

        PaperTrail.whodunnit = email

        dato = Afiliacion.new new_row_hash
        dato.partido = partido
        dato.save
        filas_importadas = filas_importadas + 1
      rescue
        errores = errores + 1
      end

    end
    return_values = { :errores => errores, :filas_importadas => filas_importadas }
  end

  def self.to_csv
    attributes = %w{ region_id  ano_nacimineto hombres mujeres otros}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |persona|
        csv << attributes.map{|attr| persona.send(attr)}
      end
    end
  end


end
