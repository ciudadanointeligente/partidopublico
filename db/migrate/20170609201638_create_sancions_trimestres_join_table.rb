class CreateSancionsTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :sancions, :trimestre_informados do |t|
      t.index :sancion_id, :name => 't_i_sancion_id'
      t.index :trimestre_informado_id, :name => 't_i_sancion_trimestre_id'
    end
  end
end
