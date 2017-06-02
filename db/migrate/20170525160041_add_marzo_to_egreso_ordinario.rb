class AddMarzoToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :marzo, :int
  end
end
