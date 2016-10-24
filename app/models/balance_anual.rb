# == Schema Information
#
# Table name: balance_anuals
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  tipo        :string
#  importe     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_balance_anuals_on_partido_id  (partido_id)
#

class BalanceAnual < ActiveRecord::Base
  has_paper_trail
  belongs_to :partido

  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        #puts "importin balance anual"
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, 12, 01)
        new_row_hash.delete('ano_datos')
        PaperTrail.whodunnit = email
        dato = BalanceAnual.new new_row_hash
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
