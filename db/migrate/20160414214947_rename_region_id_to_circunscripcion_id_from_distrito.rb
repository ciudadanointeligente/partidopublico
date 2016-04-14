class RenameRegionIdToCircunscripcionIdFromDistrito < ActiveRecord::Migration
  def change
    rename_column :distritos, :region_id, :circunscripcion_id
  end
end
