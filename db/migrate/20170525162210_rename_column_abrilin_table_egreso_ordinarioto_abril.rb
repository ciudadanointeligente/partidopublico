class RenameColumnAbrilinTableEgresoOrdinariotoAbril < ActiveRecord::Migration
  def change
    rename_column :egreso_ordinarios, :Abril, :abril
  end
end
