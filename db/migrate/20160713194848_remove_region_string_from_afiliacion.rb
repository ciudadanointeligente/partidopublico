class RemoveRegionStringFromAfiliacion < ActiveRecord::Migration
  def change
    remove_column :afiliacions, :region
  end
end
