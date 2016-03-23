class AddPartidoToOrganoInterno < ActiveRecord::Migration
  def change
    add_reference :organo_internos, :partido, index: true, foreign_key: true
  end
end
