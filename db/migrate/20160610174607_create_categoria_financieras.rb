class CreateCategoriaFinancieras < ActiveRecord::Migration
  def change
    create_table :categoria_financieras do |t|
      t.references :partido
      t.references :documento
      t.date :fecha
      t.string :titulo

      t.timestamps null: false
    end
  end
end
