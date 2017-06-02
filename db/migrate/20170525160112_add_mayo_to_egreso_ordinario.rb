class AddMayoToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :Mayo, :int
  end
end
