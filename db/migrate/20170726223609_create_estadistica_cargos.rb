class CreateEstadisticaCargos < ActiveRecord::Migration
  def change
    create_table :estadistica_cargos do |t|
      t.references :partido, index: true, foreign_key: true
      t.string :item
      t.integer :cantidad_mujeres
      t.integer :cantidad_hombres
      t.string :porcentaje_mujeres
      t.string :porcentaje_hombres
      t.timestamps null: false
    end
  end
end
