class CreateIngresoOrdinariosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :ingreso_ordinarios, :trimestre_informados do |t|
      t.index :ingreso_ordinario_id, :name => 't_i_ingreso_ordinario_id'
      t.index :trimestre_informado_id, :name => 't_i_i_o_trimestre_id'
    end
  end
end
