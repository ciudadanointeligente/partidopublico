class CreateSedes < ActiveRecord::Migration
  def change
    create_table :sedes do |t|
      t.string :region
      t.string :direccion
      t.string :contacto

      t.timestamps null: false
    end
  end
end
