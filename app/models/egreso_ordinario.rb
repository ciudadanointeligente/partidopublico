# == Schema Information
#
# Table name: egreso_ordinarios
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  privado     :integer
#  publico     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enero       :integer
#  febrero     :integer
#  marzo       :integer
#  abril       :integer
#  mayo        :integer
#  junio       :integer
#  julio       :integer
#  agosto      :integer
#  septiembre  :integer
#  octubre     :integer
#  noviembre   :integer
#  diciembre   :integer
#
# Indexes
#
#  index_egreso_ordinarios_on_partido_id  (partido_id)
#

class EgresoOrdinario < ActiveRecord::Base
  # has_paper_trail
  belongs_to :partido
  has_and_belongs_to_many :trimestre_informados

  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        #puts "importin egresos ordinarios"
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')
        PaperTrail.whodunnit = email
        dato = EgresoOrdinario.new new_row_hash
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
