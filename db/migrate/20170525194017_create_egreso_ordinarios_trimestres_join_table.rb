class CreateEgresoOrdinariosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :egreso_ordinarios, :trimestre_informados do |t|
      t.index :egreso_ordinario_id, :name => 't_i_egreso_ordinario_id'
      t.index :trimestre_informado_id, :name => 't_i_eg_o_trimestre_id'
    end
  end
end
