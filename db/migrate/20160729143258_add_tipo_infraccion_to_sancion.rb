class AddTipoInfraccionToSancion < ActiveRecord::Migration
  def change
    add_column :sancions, :tipo_infraccion, :string
  end
end
