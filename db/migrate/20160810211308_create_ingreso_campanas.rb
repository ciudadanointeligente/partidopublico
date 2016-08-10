class CreateIngresoCampanas < ActiveRecord::Migration
  def change
    create_table :ingreso_campanas do |t|
      t.references :partido, index: true, foreign_key: true
      t.date :fecha_datos
      t.date :fecha_eleccion
      t.string :rut_candidato
      t.string :rut_donante
      t.string :nombre_donante
      t.date :fecha_documento
      t.string :tipo_documento
      t.string :numero_documento
      t.string :numero_cuenta
      t.string :glosa
      t.integer :monto

      t.timestamps null: false
    end
  end
end
