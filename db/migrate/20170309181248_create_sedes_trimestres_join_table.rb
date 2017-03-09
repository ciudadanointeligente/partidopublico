class CreateSedesTrimestresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :sedes, :trimestre_informados do |t|
      t.index :sede_id
      t.index :trimestre_informado_id
    end
  end
end
