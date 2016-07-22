class AddRegionRefToAfiliacion < ActiveRecord::Migration
  def change
    add_reference :afiliacions, :region, index: true, foreign_key: true    
  end
end
