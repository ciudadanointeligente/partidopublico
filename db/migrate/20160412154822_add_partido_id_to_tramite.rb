class AddPartidoIdToTramite < ActiveRecord::Migration
  def change
    add_reference :tramites, :partido, index: true, foreign_key: true
  end
end
