class CreateIngresoOrdinarios < ActiveRecord::Migration
  def change
    create_table :ingreso_ordinarios do |t|
      t.date :fecha_datos
      t.string :concepto
      t.integer :importe
      t.timestamps null: false
    end
  end
end
