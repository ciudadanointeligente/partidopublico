class CreateEleccionPopulars < ActiveRecord::Migration
  def change
    create_table :eleccion_populars do |t|
      t.date :fecha_eleccion
      t.integer :dias
      t.string :cargo

      t.timestamps null: false
    end
  end
end
