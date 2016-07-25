class AddPartidoRefToTipoCargo < ActiveRecord::Migration
  def change
    add_reference :tipo_cargos, :partido, index: true, foreign_key: true  
  end
end
