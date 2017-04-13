class AddEstadoToEgresoCampana < ActiveRecord::Migration
  def change
    add_column :egreso_campanas, :estado, :string
  end
end
