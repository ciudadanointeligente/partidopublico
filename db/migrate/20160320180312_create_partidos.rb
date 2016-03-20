class CreatePartidos < ActiveRecord::Migration
  def change
    create_table :partidos do |t|
      t.string  :nombre, null: false
      t.string  :sigla, null: false
      t.string  :lema, null: false
      t.date    :fecha_fundacion
      t.text    :texto
      t.timestamps null: false
    end
  end
end
