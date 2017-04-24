class CreateAfiliacionTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :afiliacions, :trimestre_informados do |t|
      t.index :afiliacion_id, :name => 't_i_afiliacion_id'
      t.index :trimestre_informado_id, :name => 't_i_a_trimestre_id'
    end
  end
end
