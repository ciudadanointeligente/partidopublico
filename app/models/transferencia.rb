# == Schema Information
#
# Table name: transferencias
#
#  id           :integer          not null, primary key
#  partido_id   :integer
#  fecha_datos  :date
#  numero       :string
#  razon_social :string
#  rut          :string
#  region_id    :integer
#  descripcion  :string
#  monto        :integer
#  categoria    :string
#  fecha        :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_transferencias_on_partido_id  (partido_id)
#  index_transferencias_on_region_id   (region_id)
#

class Transferencia < ActiveRecord::Base
  has_paper_trail
  belongs_to :partido
  belongs_to :region


  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        puts "importin Transferencias"
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')
        region = Region.find_by_ordinal new_row_hash['region']
        new_row_hash['region_id'] = region.id
        new_row_hash.delete('region')
        PaperTrail.whodunnit = email
        dato = Transferencia.new new_row_hash
        dato.partido = partido
        puts "dato:"
        puts dato
        dato.save
        filas_importadas = filas_importadas + 1
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
        errores = errores + 1
      end
    end
    return_values = { :errores => errores, :filas_importadas => filas_importadas }
  end

end
