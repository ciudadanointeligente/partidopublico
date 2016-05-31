class RemoveRegionFromCircunscripcion < ActiveRecord::Migration
  def change
    remove_column :circunscripcions, :region_id
  end
end
