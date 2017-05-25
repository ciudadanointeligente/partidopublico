class AddAgostoToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :agosto, :int
  end
end
