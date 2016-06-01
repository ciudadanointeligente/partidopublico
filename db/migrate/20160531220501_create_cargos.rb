class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.references :persona, index: true, foreign_key: true
      t.references :tipo_cargo, index: true, foreign_key: true
      t.references :partido, index: true, foreign_key: true

      t.references :region, index: true, foreign_key: true
      t.references :comuna, index: true, foreign_key: true
      t.references :circunscripcion, index: true, foreign_key: true
      t.references :distrito, index: true, foreign_key: true

      t.date :fecha_desde
      t.date :fecha_hasta

      t.timestamps null: false
    end
  end
end
