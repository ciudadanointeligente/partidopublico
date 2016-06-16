class CreateItemsContables < ActiveRecord::Migration
  def change
    create_table :item_contables do |t|
      t.references :categoria_financiera
      t.string :concepto
      t.boolean :dinero_publico
      t.integer :importe
      t.references :partido

      t.timestamps null: false
    end
  end
end
