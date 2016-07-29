class AddTipoSancionToSancion < ActiveRecord::Migration
  def change
    add_column :sancions, :tipo_sancion, :string
  end
end
