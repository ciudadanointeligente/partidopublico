class AddTipoToPactoElectorals < ActiveRecord::Migration
  def change
    add_column :pacto_electorals, :tipo, :string
  end
end
