class CreateAcuerdosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :acuerdos, :trimestre_informados do |t|
      t.index :acuerdo_id, :name => 't_i_acuerdo_id'
      t.index :trimestre_informado_id, :name => 't_i_acuerdo_trimestre_id'
    end
  end
end
