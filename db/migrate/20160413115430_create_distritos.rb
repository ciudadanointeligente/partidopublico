class CreateDistritos < ActiveRecord::Migration
  def change
    create_table :distritos do |t|
      t.references :region, index: true, foreign_key: true
      t.string :nombre

      t.timestamps null: false
    end
  end
end
