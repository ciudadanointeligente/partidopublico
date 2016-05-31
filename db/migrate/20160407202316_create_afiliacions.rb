class CreateAfiliacions < ActiveRecord::Migration
  def change
    create_table :afiliacions do |t|
      t.references :region, index: true, foreign_key: true
      t.integer :hombres
      t.integer :mujeres
      t.string :rangos

      t.timestamps null: false
    end
  end
end
