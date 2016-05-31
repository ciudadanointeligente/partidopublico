class CreateJoinTablePartidoRegion < ActiveRecord::Migration
  def change
    create_join_table :partidos, :regions do |t|
      t.index [:partido_id, :region_id]
      t.index [:region_id, :partido_id]
    end
  end
end
