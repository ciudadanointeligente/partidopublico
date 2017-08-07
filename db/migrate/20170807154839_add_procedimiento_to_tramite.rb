class AddProcedimientoToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :procedimiento, :string
  end
end
