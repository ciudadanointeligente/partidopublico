class AddRutToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :rut, :string
  end
end
