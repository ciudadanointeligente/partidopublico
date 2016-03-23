class CreateLeys < ActiveRecord::Migration
  def change
    create_table :leys do |t|
      t.string :numero
      t.string :nombre
      t.string :enlace
      t.string :tags
      t.string :resumen
      t.references :marco_general, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
