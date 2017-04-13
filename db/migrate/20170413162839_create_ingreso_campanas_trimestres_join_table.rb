class CreateIngresoCampanasTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :ingreso_campanas, :trimestre_informados do |t|
      t.index :ingreso_campana_id, :name => 't_i_ingreso_campana_id'
      t.index :trimestre_informado_id, :name => 't_i_i_c_trimestre_id'
    end
  end
end
