class CreateContratacions < ActiveRecord::Migration
  def change
    create_table :contratacions do |t|
      t.references :partido, index: true, foreign_key: true
      t.date :fecha_datos
      t.string :numero
      t.string :individualizacion
      t.string :razon_social
      t.string :rut
      t.string :titulares
      t.string :descripcion
      t.integer :monto
      t.date :fecha_inicio
      t.date :fecha_termino
      t.string :link

      t.timestamps null: false
    end
  end
end
