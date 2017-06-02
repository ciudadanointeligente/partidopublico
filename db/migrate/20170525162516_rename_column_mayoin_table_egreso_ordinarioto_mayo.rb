class RenameColumnMayoinTableEgresoOrdinariotoMayo < ActiveRecord::Migration
  def change
    rename_column :egreso_ordinarios, :Mayo, :mayo
  end
end
