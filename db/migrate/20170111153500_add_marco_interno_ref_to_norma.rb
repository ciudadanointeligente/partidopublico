class AddMarcoInternoRefToNorma < ActiveRecord::Migration
  def change
    add_reference :normas, :marco_interno, index: true, foreign_key: true
  end
end
