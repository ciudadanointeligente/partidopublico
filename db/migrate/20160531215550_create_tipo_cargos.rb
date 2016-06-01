class CreateTipoCargos < ActiveRecord::Migration
  def change
    create_table :tipo_cargos do |t|
      t.string :titulo

      t.timestamps null: false
    end
  end
end
