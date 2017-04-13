class AddItemToEgresoCampana < ActiveRecord::Migration
  def change
    add_column :egreso_campanas, :item, :string
  end
end
