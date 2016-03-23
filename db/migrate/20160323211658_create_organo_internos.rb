class CreateOrganoInternos < ActiveRecord::Migration
  def change
    create_table :organo_internos do |t|
      t.string :nombre
      t.string :funciones

      t.timestamps null: false
    end
  end
end
