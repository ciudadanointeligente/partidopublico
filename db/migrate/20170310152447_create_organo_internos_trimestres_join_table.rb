class CreateOrganoInternosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :organo_internos, :trimestre_informados do |t|
      t.index :organo_interno_id, :name => 't_i_organo_id'
      t.index :trimestre_informado_id, :name => 't_i_trimestre_id'
    end
  end
end
