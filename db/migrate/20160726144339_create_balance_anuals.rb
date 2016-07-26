class CreateBalanceAnuals < ActiveRecord::Migration
  def change
    create_table :balance_anuals do |t|
      t.references :partido, index: true, foreign_key: true
      t.date :fecha_datos
      t.string :concepto
      t.string :tipo
      t.bigint :importe

      t.timestamps null: false
    end
  end
end
