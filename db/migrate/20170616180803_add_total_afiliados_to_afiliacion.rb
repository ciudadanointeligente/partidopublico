class AddTotalAfiliadosToAfiliacion < ActiveRecord::Migration
  def change
    add_column :afiliacions, :total_afiliados, :integer
  end
end
