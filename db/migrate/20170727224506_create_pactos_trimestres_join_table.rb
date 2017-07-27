class CreatePactosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :pacto_electorals, :trimestre_informados do |t|
      t.index :pacto_electoral_id, :name => 't_i_pacto_id'
      t.index :trimestre_informado_id, :name => 't_i_pacto_trimestre_id'
    end
  end
end
