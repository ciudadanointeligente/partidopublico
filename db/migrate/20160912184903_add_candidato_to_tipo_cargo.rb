class AddCandidatoToTipoCargo < ActiveRecord::Migration
  def change
    add_column :tipo_cargos, :candidato, :boolean
  end
end
