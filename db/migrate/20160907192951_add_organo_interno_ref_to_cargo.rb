class AddOrganoInternoRefToCargo < ActiveRecord::Migration
  def change
    add_reference :cargos, :organo_interno, index: true, foreign_key: true
  end
end
