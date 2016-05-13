class CreateActividadPublicas < ActiveRecord::Migration
  def change
    create_table :actividad_publicas do |t|
      t.date :fecha
      t.string :descripcion
      t.string :link
      t.string :lugar
      t.references :partido, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
