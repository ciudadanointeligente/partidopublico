class CreateMarcoInternos < ActiveRecord::Migration
  def change
    create_table :marco_internos do |t|
      t.references :partido, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
