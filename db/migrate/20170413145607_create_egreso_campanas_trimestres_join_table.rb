class CreateEgresoCampanasTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :egreso_campanas, :trimestre_informados do |t|
      t.index :egreso_campana_id, :name => 't_i_egreso_campana_id'
      t.index :trimestre_informado_id, :name => 't_i_e_c_trimestre_id'
    end
  end
end
