class AddEneroToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :enero, :int
  end
end
