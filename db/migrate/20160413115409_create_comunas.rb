class CreateComunas < ActiveRecord::Migration
  def change
    create_table :comunas do |t|
      t.references :provincia, index: true, foreign_key: true
      t.string :nombre

      t.timestamps null: false
    end
  end
end
