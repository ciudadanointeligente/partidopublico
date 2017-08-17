class AddTipoCargoToEstadisticaCargo < ActiveRecord::Migration
  def change
    add_column :estadistica_cargos, :tipo_cargo, :string
  end
end
