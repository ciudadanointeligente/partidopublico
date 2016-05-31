class CreateJoinTablePactosPartidos < ActiveRecord::Migration
  def change
    create_join_table :pacto_electorals, :partidos do |t|
      # t.index [:pacto_electoral_id, :partido_id]
      # t.index [:partido_id, :pacto_electoral_id]
    end
  end
end
