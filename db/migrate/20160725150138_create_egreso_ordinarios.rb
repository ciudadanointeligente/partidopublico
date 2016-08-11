class CreateEgresoOrdinarios < ActiveRecord::Migration
  def change
    create_table :egreso_ordinarios do |t|
      t.references :partido, index: true, foreign_key: true
      t.date :fecha_datos
      t.string :concepto
      t.integer :privado
      t.integer :publico

      t.timestamps null: false
    end
  end
end
