class RenameProveedorToNombreProveedorAtEgresoCampanas < ActiveRecord::Migration
  def change
    rename_column :egreso_campanas, :proveedor, :nombre_proveedor
    remove_column :egreso_campanas, :nombre
  end
end
