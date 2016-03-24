class CreateAcuerdos < ActiveRecord::Migration
  def change
    create_table :acuerdos do |t|
      t.string :numero
      t.date :fecha
      t.string :tipo
      t.string :tema
      t.string :region
      t.references :organo_interno, index: true, foreign_key: true
      t.attachment :documento
      t.timestamps null: false
    end
  end
end
