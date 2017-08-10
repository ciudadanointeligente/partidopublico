# == Schema Information
#
# Table name: ingreso_ordinarios
#
#  id          :integer          not null, primary key
#  fecha_datos :date
#  concepto    :string
#  importe     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  partido_id  :integer
#
# Indexes
#
#  index_ingreso_ordinarios_on_partido_id  (partido_id)
#

class IngresoOrdinario < ActiveRecord::Base
  # has_paper_trail
  belongs_to :partido
  has_and_belongs_to_many :trimestre_informados

  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    #puts " found partido: "
    #puts partido
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        #puts "importin ingresos ordinarios"
        #puts "partido_id"
        #puts partido_id
        #puts "row.to_hash"
        #puts row.to_hash
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')
        #puts "new_row_hash"
        #puts new_row_hash
        PaperTrail.whodunnit = email
        dato = IngresoOrdinario.new new_row_hash
        dato.partido = partido
        #puts "dato.partido: "
        #puts dato.partido
        #puts "dato:"
        #puts dato
        dato.save
        if dato.errors.any?
          #puts "dato.errors:"
          #puts dato.errors
        end
        #puts dato
        filas_importadas = filas_importadas + 1
      rescue Exception => e
        #puts e.message
        #puts e.backtrace.inspect
        errores = errores + 1
      end

    end
    return_values = { :errores => errores, :filas_importadas => filas_importadas }
    #puts return_values
    return_values = { :errores => errores, :filas_importadas => filas_importadas }
  end

end
