class CreateNormas < ActiveRecord::Migration
  def change
    create_table :normas do |t|
      t.date :fecha_datos
      t.string :tipo_marco_normativo
      t.string :tipo
      t.string :numero
      t.string :denominacion
      t.date :fecha_publicacion
      t.string :link
      t.date :fecha_modificacion

      t.timestamps null: false
    end
  end
end
