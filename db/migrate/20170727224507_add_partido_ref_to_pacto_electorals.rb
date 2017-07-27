class AddPartidoRefToPactoElectorals < ActiveRecord::Migration
  def change
    add_reference :pacto_electorals, :partido, index: true, foreign_key: true
  end
end
