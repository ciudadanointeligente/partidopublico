class RemoveRangoToAfiliacion < ActiveRecord::Migration
  def change
    remove_column :afiliacions, :rangos
  end
end
