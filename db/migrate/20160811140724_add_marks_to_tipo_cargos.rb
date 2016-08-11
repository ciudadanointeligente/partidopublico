class AddMarksToTipoCargos < ActiveRecord::Migration
  def change
    add_column :tipo_cargos, :cargo_interno, :boolean, index: true
    add_column :tipo_cargos, :representante, :boolean, index: true
    add_column :tipo_cargos, :autoridad, :boolean, index: true
  end
end
