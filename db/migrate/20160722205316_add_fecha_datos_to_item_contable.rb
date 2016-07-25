class AddFechaDatosToItemContable < ActiveRecord::Migration
  def change
     add_column :item_contables, :fecha_datos, :date
  end
end
