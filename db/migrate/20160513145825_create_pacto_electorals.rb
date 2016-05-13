class CreatePactoElectorals < ActiveRecord::Migration
  def change
    create_table :pacto_electorals do |t|
      t.integer :ano_eleccion
      t.string :nombre_pacto
      t.string :descripcion
      t.timestamps null: false
    end
  end
end
