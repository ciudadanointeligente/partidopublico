class CreateTransferencias < ActiveRecord::Migration
  def change
    create_table :transferencias do |t|
      t.references :partido, index: true, foreign_key: true
      t.date :fecha_datos
      t.string :numero
      t.string :razon_social
      t.string :rut
      t.references :region, index: true, foreign_key: true
      t.string :descripcion
      t.integer :monto
      t.string :categoria
      t.date :fecha

      t.timestamps null: false
    end
  end
end
