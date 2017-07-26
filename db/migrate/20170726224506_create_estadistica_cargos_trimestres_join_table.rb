class CreateEstadisticaCargosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :estadistica_cargos, :trimestre_informados do |t|
      t.index :estadistica_cargo_id, :name => 't_i_estadistica_cargo_id'
      t.index :trimestre_informado_id, :name => 't_i_estadistica_cargo_trimestre_id'
    end
  end
end
