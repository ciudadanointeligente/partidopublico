class CreateTramitesTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tramites, :trimestre_informados do |t|
      t.index :tramite_id, :name => 't_i_tramite_id'
      t.index :trimestre_informado_id, :name => 't_i_tramite_trimestre_id'
    end
  end
end
