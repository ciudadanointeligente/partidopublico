class AddNombreApellidosToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :nombre, :string
    add_column :personas, :apellidos, :string
  end
end
