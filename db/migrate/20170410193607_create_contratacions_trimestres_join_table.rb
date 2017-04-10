class CreateContratacionsTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :contratacions, :trimestre_informados do |t|
      t.index :contratacion_id, :name => 't_i_contratacion_id'
      t.index :trimestre_informado_id, :name => 't_i_contr_trimestre_id'
    end
  end
end
