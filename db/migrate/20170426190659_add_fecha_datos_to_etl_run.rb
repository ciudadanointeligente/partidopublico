class AddFechaDatosToEtlRun < ActiveRecord::Migration
  def change
    add_column :etl_runs, :fecha_datos, :date
  end
end
