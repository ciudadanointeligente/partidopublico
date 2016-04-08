class AddRegionToAfiliacion < ActiveRecord::Migration
  def change
    add_column :afiliacions, :region, :string
  end
end
