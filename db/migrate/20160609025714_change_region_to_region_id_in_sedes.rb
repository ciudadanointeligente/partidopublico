class ChangeRegionToRegionIdInSedes < ActiveRecord::Migration
  def change
    remove_column :sedes, :region
    add_column :sedes, :region_id, :integer
  end
end
