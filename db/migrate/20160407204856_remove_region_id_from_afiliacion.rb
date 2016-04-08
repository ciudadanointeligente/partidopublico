class RemoveRegionIdFromAfiliacion < ActiveRecord::Migration
  def change
    remove_column :afiliacions, :region_id
  end
end
