class CreateCargosTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :cargos, :trimestre_informados do |t|
      t.index :cargo_id, :name => 't_i_cargo_id'
      t.index :trimestre_informado_id, :name => 't_i_c_trimestre_id'
    end
  end
end
