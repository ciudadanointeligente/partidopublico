class CreateEleccionInternas < ActiveRecord::Migration
  def change
    create_table :eleccion_internas do |t|
      t.references :organo_interno, index: true, foreign_key: true
      t.date :fecha_eleccion
      t.date :fecha_limite_inscripcion
      t.string :cargo

      t.timestamps null: false
    end
  end
end
