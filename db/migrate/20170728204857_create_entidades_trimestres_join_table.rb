class CreateEntidadesTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :participacion_entidads, :trimestre_informados do |t|
      t.index :participacion_entidad_id, :name => 't_i_participacion_entidad_id'
      t.index :trimestre_informado_id, :name => 't_i_participacion_entidad_trimestre_id'
    end
  end
end
