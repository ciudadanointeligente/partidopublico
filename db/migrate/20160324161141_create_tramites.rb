class CreateTramites < ActiveRecord::Migration
  def change
    create_table :tramites do |t|
      t.string :nombre
      t.string :descripcion
      t.references :persona, index: true, foreign_key: true
      t.attachment :documento
      t.timestamps null: false
    end
  end
end
