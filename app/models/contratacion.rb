# == Schema Information
#
# Table name: contratacions
#
#  id                :integer          not null, primary key
#  partido_id        :integer
#  fecha_datos       :date
#  numero            :string
#  individualizacion :string
#  razon_social      :string
#  rut               :string
#  titulares         :string
#  descripcion       :string
#  monto             :integer
#  fecha_inicio      :date
#  fecha_termino     :date
#  link              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_contratacions_on_partido_id  (partido_id)
#

class Contratacion < ActiveRecord::Base
  belongs_to :partido

  def self.import(file, partido_id, email)
    partido = Partido.find partido_id
    filas_importadas = 0
    errores = 0
    CSV.foreach(file.path, headers: true) do |row|
      begin
        puts "importin contrataciones"
        new_row_hash = row.to_hash
        new_row_hash['fecha_datos'] = Date.new(new_row_hash['ano_datos'].to_i, new_row_hash['mes_datos'].to_i, 01)
        new_row_hash.delete('ano_datos')
        new_row_hash.delete('mes_datos')
        PaperTrail.whodunnit = email
        dato = Contratacion.new new_row_hash
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
