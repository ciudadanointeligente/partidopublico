class CreateTransferenciasTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :transferencias, :trimestre_informados do |t|
      t.index :transferencia_id, :name => 't_i_transferencia_id'
      t.index :trimestre_informado_id, :name => 't_i_t_trimestre_id'
    end
  end
end
