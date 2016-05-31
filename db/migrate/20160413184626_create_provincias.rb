class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :nombre
      t.references :region, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
