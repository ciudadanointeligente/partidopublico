class AddJulioToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :julio, :int
  end
end
