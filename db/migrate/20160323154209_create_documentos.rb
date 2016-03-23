class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.string :descripcion
      t.references :documentable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
