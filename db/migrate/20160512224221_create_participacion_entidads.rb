class CreateParticipacionEntidads < ActiveRecord::Migration
  def change
    create_table :participacion_entidads do |t|
      t.string :entidad
      t.string :descripcion
      t.attachment :documento
      t.references :partido, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
