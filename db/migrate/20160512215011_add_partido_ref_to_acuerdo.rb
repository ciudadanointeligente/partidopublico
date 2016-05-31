class AddPartidoRefToAcuerdo < ActiveRecord::Migration
  def change
    add_reference :acuerdos, :partido, index: true, foreign_key: true
  end
end
