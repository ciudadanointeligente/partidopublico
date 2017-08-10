# == Schema Information
#
# Table name: ingreso_campanas
#
#  id               :integer          not null, primary key
#  partido_id       :integer
#  fecha_datos      :date
#  fecha_eleccion   :date
#  rut_candidato    :string
#  rut_donante      :string
#  nombre_donante   :string
#  fecha_documento  :date
#  tipo_documento   :string
#  numero_documento :string
#  numero_cuenta    :string
#  glosa            :string
#  monto            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tipo_aporte      :string
#
# Indexes
#
#  index_ingreso_campanas_on_partido_id  (partido_id)
#

class IngresoCampana < ActiveRecord::Base
  # has_paper_trail
  belongs_to :partido
  has_and_belongs_to_many :trimestre_informados

  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        #puts "importin Ingresos Campaña"
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')
        PaperTrail.whodunnit = email
        dato = IngresoCampana.new new_row_hash
        dato.partido = partido
        #puts "dato:"
        #puts dato
        dato.save
        filas_importadas = filas_importadas + 1
      rescue Exception => e
        #puts e.message
        #puts e.backtrace.inspect
        errores = errores + 1
      end
    end
    return_values = { :errores => errores, :filas_importadas => filas_importadas }
  end

end
