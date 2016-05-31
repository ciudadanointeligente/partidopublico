class AddRepresentanteFieldsToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :cargo, :string
    add_column :personas, :distrito, :string
    add_column :personas, :circunscripcion, :string
    add_column :personas, :comuna, :string
    add_column :personas, :telefono, :string
    add_column :personas, :email, :string
    add_column :personas, :fecha_desde, :date
    add_column :personas, :fecha_hasta, :date
  end
end
