class AddComunaToSede < ActiveRecord::Migration
  def change
    add_reference :sedes, :comuna, index: true, foreign_key: true
  end
end
